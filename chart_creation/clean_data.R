library(tidyverse)
library(lubridate)
library(rvest)
library(pander)

# Book of Mormon weekly reading schedule
# Adapted from http://www.ldsscripturetools.com/plan.php
bom.raw <- read_csv("original_schedules/bom.csv")

bom <- bom.raw %>%
  mutate(Date = mdy(paste(Date, 2017)),
         Week = week(Date))

bom.weekly <- bom %>%
  group_by(Week) %>%
  summarise(Readings = paste(Reading, collapse="; "))

write_csv(bom.weekly, "original_schedules/bom_weekly_OVERWRITE.csv")

bom.weekly.final <- read_csv("final_schedules/bom_weekly_final.csv") %>%
  rename(`Book of Mormon` = Readings)


# Book of Mormon highlights reading schedule
# Adapted from https://www.lds.org/friend/2012/01/book-of-mormon-feast
bom.highlights.raw <- "https://www.lds.org/friend/2012/01/book-of-mormon-feast" %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="primary"]/div[3]/table') %>%
  html_table()
bom.highlights.final <- bom.highlights.raw[[1]] %>%
  rename(`Book of Mormon highlights` = Reading)

write_csv(bom.highlights.final, "final_schedules/bom_highlights_final.csv")


# Doctrine and Covenants reading schedule
# Adapted from http://www.jonfullmer.com/schedules/
#
# Convert ics files to csv with http://projectwizards.net/en/support/ics2csv
dc.raw <- read_tsv("original_schedules/dc-ical.csv")

dc <- dc.raw %>%
  select(Reading = Title, Date = `Given planned earliest start`) %>%
  mutate(Date = mdy(Date),
         Month = month(Date),
         Day = day(Date),
         Date = ymd(paste(2017, Month, Day, sep="-")),
         Week = week(Date)) %>%
  arrange(Date)

dc.weekly <- dc %>%
  group_by(Week) %>%
  summarise(Readings = paste(Reading, collapse="; "))

write_csv(dc.weekly, "original_schedules/dc_weekly_OVERWRITE.csv")

dc.weekly.final <- read_csv("final_schedules/dc_weekly_final.csv") %>%
  rename(`D&C` = Readings)


# Full schedule for all three tracks
full.schedule <- data_frame(Date = ymd(format(seq(ymd("2017-01-01"), 
                                                  by="1 day", length.out=365), 
                                              "%Y-%m-%d"))) %>%
  arrange(Date) %>%
  mutate(Week = week(Date),
         Week = ifelse(Week == 53, 52, Week)) %>%
  group_by(Week) %>%
  summarise(Dates = paste(format(first(Date), "%B %e"), 
                          format(last(Date), "%B %e"),
                          sep="–")) %>%
  left_join(dc.weekly.final, by="Week") %>%
  left_join(bom.weekly.final, by="Week") %>%
  left_join(bom.highlights.final, by="Week")

cat(pandoc.table.return(select(full.schedule, Dates, Reading=`Book of Mormon`),
                        split.tables=Inf, split.cells=Inf, justify="ll",
                        style="rmarkdown"), file="schedule_output/bom.md")

cat(pandoc.table.return(select(full.schedule, Dates, Reading=`Book of Mormon highlights`),
                        split.tables=Inf, split.cells=Inf, justify="ll",
                        style="rmarkdown"), file="schedule_output/bom-highlights.md")

cat(pandoc.table.return(select(full.schedule, Dates, Reading=`D&C`),
                        split.tables=Inf, split.cells=Inf, justify="ll",
                        style="rmarkdown"), file="schedule_output/dc.md")
