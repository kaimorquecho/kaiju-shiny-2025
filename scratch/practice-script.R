# load packages ----
library(tidyverse)
library(palmerpenguins)
library(DT)

# filter penguin df for obs where body_mass_g >= 3000 & <= 4000
body_mass_df <- penguins %>% 
  filter(body_mass_g %in% c(3000:4000))


# create scatterplot ----
ggplot(na.omit(penguins), 
       aes(x = flipper_length_mm, y = bill_length_mm, 
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("Adelie" = "indianred2", "Chinstrap" = "skyblue3", "Gentoo" = "gold")) +
  scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
  labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
       color = "Penguin species", shape = "Penguin species") +
  guides(color = guide_legend(position = "inside"),
         size = guide_legend(position = "inside")) +
  theme_minimal() +
  theme(text = element_text(family = "courier"),
        legend.position.inside = c(0.85, 0.2), 
        legend.background = element_rect(color = "white"))


select_years_df <- penguins %>% 
  filter(year %in% c(2007,2008))

# create a DT data table of penguins data
select_years_dt <- DT::datatable(select_years_df)







