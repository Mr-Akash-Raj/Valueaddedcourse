# Load required packages
library(rvest)
library(tidyverse)

# Set the URL of the webpage to scrape
url <- "https://www.fifa.com/worldcup/players/top25/"

# Use read_html() to scrape the HTML code from the webpage
page <- read_html(url)

# Use Selector Gadget to select the table containing the football player data
selector <- "#topPlayersContainer table"

# Use html_nodes() to select the table using the CSS selector
table <- page %>% html_nodes(selector) %>% .[[1]]

# Use html_table() to convert the table into a data frame
players_df <- table %>% html_table()

# Clean and process the data as needed
players_df <- players_df %>% 
  filter(row_number() > 1) %>%  # Remove the header row
  rename(Rank = 1, Name = 2, Team = 3, Goals = 4) %>%  # Rename columns
  mutate(Goals = as.numeric(Goals)) %>%  # Convert Goals column to numeric
  slice(1:25)  # Select the top 25 players

# View the resulting data frame
players_df
