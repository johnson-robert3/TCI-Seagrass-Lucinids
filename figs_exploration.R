#--
# Exploratory figures
#
#--


library(patchwork)


# Thalassia coverage along transects
windows(height=3.5, width=5)
ggplot(sg_density %>%
         left_join(site_data %>% select(site_location, transect_id, transect_position))) +
  # 
  geom_line(aes(x = transect_distance_m, y = cover_Tt, group = transect_id, color = site_location, linetype = transect_position)) +
  geom_point(aes(x = transect_distance_m, y = cover_Tt, color = site_location, shape = transect_position)) +
  #
  scale_x_continuous(name = "Distance (m)", limits = c(0, 10), breaks = seq(1, 9, 2)) +
  scale_y_continuous(name = "Thalassa % cover") +
  theme_classic()


