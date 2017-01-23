library(tidyverse)
library(lubridate)

all.readings <- list("Doctrine and Covenants" =
                       read_csv("final_schedules/dc_weekly_final.csv"),
                     "Book of Mormon" = 
                       read_csv("final_schedules/bom_weekly_final.csv"),
                     "Book of Mormon highlights" =
                       read_csv("final_schedules/bom_highlights_final.csv") %>%
                       rename(Readings = `Book of Mormon highlights`)) %>%
  bind_rows(.id="Book")

prose <- tribble(
  ~destination, ~intro, ~closing,
  "email", "Hi everyone!\nHere are this week's readings for the ward's Scriptures of the Restoration goal:", "Remember to check out the schedule and resources at https://www.scripturesoftherestoration.org/\nThanks!",
  "facebook", "Hi everyone! Here are this week's readings for the ward's Scriptures of the Restoration goal:", "Remember to check out the schedule and resources online https://scripturesoftherestoration.org/"
)

assignments <- all.readings %>%
  group_by(Week) %>%
  summarise(Assignment = paste0("• ", Book, ": ", Readings, collapse="\n")) %>%
  mutate(Date = parse_date_time(paste("2017", Week, "0", sep="-"), "%Y-%W-%w", exact=TRUE))

assignments.prose <- expand.grid(destination=prose$destination,
                                 Week=assignments$Week,
                                 stringsAsFactors=FALSE) %>%
  left_join(assignments, by="Week") %>%
  left_join(prose, by="destination")

assignments.prose %>%
  nest(-destination, -Week) %>%
  do(thing = map2(.x=.$data, .y=.$destination,
                  .f = ~ cat(paste0(.x$intro, "\n\n", .x$Assignment, "\n\n", .x$closing),
                             file=file.path("reminders",
                                            paste0(.x$Date, "-", .y, ".txt")))))
