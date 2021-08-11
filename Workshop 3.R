library(tidymodels)
library(skimr)
library(janitor)
library(tidyverse)


muffin_cupcake_dat_original<-read_csv("https://raw.githubusercontent.com/adashofdata/muffin-cupcake/master/recipes_muffins_cupcakes.csv")

#muffin_recipe<-recipe(type~flour+milk+sugar+egg, data = muffin_cupcake_training)
#muffin_recipe_steps<-muffin_recipe%>%
  step_meanimpute(all_numeric())
  
#prepped_recipe<-prep(muffin_recipe_steps, training=muffin_cupcake_training)
  


#clean variable names

muffin_cupcake_data<-muffin_cupcake_dat_original%>%
  clean_names()
muffin_cupcake_data%>%count(type)

#splitting the cleaned dataset into training vs testing

muffin_cupcake_split<-initial_split(muffin_cupcake_data)

muffin_cupcake_train<-training(muffin_cupcake_split) 
