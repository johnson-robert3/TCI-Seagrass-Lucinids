#--
# Script to import and process TCI data
#
#--


library(tidyverse)
library(readxl)


# data
site_data = read_xlsx(path = "C:/Users/rajohnson6/Box/Turks & Caicos/Seagrass-Lucinid Student DR - F23/Seagrass_Lucinid_DataSheet.xlsx",
                      sheet = "Metadata")

sg_morphometry = read_xlsx(path = "C:/Users/rajohnson6/Box/Turks & Caicos/Seagrass-Lucinid Student DR - F23/Seagrass_Lucinid_DataSheet.xlsx",
                           sheet = "Seagrass Morphology")

sg_density = read_xlsx(path = "C:/Users/rajohnson6/Box/Turks & Caicos/Seagrass-Lucinid Student DR - F23/Seagrass_Lucinid_DataSheet.xlsx",
                       sheet = "Seagrass Data")

core_data = read_xlsx(path = "C:/Users/rajohnson6/Box/Turks & Caicos/Seagrass-Lucinid Student DR - F23/Seagrass_Lucinid_DataSheet.xlsx",
                      sheet = "Core Data")

lucinid_data = read_xlsx(path = "C:/Users/rajohnson6/Box/Turks & Caicos/Seagrass-Lucinid Student DR - F23/Seagrass_Lucinid_DataSheet.xlsx",
                         sheet = "Lucinid Measurements")


# clean up column names
site_data = site_data %>% janitor::clean_names() %>%
  rename(erosion_edge_height_m = vertical_height_of_erosion_edge_m) %>%
  # add transect position column
  mutate(transect_position = str_sub(transect_id, start=-5))

sg_morphometry = sg_morphometry %>% janitor::clean_names() %>%
  rename(transect_distance_m = blade_distance,
         blade_length_mm = length_mm,
         blade_width_mm = width_mm)

sg_density = sg_density %>% janitor::clean_names() %>%
  rename(transect_distance_m = quadrat_distance_from_edge_m,
         cover_Tt = percent_cover_t_test,
         cover_Sf = percent_cover_s_fili,
         cover_Hw = percent_cover_h_wright,
         cover_sg_tot = total_percent_coverage,
         cover_algal_tot = total_percent_algal_coverage)

core_data = core_data %>% janitor::clean_names() %>% 
  rename(transect_distance_m = core_distance,
         transect_position = above_below_seagrass_edge,
         live_lucinid_num = number_of_live_lucinids,
         dead_lucinid_num = number_of_dead_lucinids)

lucinid_data = lucinid_data %>% janitor::clean_names() %>%
  select(-date, -location_site) %>%  # these variables are already in the site_data df
  rename(transect_distance_m = core_distance,
         transect_position = above_below_seagrass_edge,
         lucinid_length_mm = length_mm) %>%
  # fix spelling in transect ID's
  mutate(transect_id = str_replace_all(transect_id, "Above", "above"),
         transect_id = str_replace_all(transect_id, "Below", "below"))


# combine site, core, and seagrass data
df = site_data %>%
  select(date, site_location, transect_id, depth_m, erosion_edge_height_m, transect_position) %>%
  right_join(core_data %>% select(-core_id, -transect_position)) %>%
  left_join(sg_density %>% select(transect_id:cover_algal_tot))




