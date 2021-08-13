library(tidymodels)
library(skimr)
library(janitor)
library(tidyverse)

#load the data
muffin_cupcake_data_orig<-read_csv("https://raw.githubusercontent.com/adashofdata/muffin-cupcake/master/recipes_muffins_cupcakes.csv")

#look at the data

muffin_cupcake_data_orig%>%skim()

#clean variable names with clean_names() from janitor package

muffin_cupcake_data<-muffin_cupcake_data_orig%>%clean_names()


#split the clean data
muffin_cupcake_split<-initial_split(muffin_cupcake_data)

#split data into train and test sets
muffin_cupcake_train<- training(muffin_cupcake_split)
muffin_cupcake_test<-testing(muffin_cupcake_split)

#define the recipe 

model_recipe<-recipe(type~flour + milk + sugar + butter + egg + baking_powder + vanilla + salt,
                     data = muffin_cupcake_train)

#define the steps we want to apply
model_recipe_steps<-model_recipe%>%
  #mean impute all numeric variables
  step_impute_mean(all_numeric())%>%
  #re scale all numeric variables except for vanilla, salt and baking_powder
  #to lie between 0 & 1
  step_range(all_numeric(), min = 0, max = 1, -vanilla, -salt, -baking_powder)%>%
  #remove predictive variables that are almost the same for every entry
  step_nzv(all_predictors())

#preparing the recipe
prepped_recipe<-prep(model_recipe_steps, training = muffin_cupcake_train)

#Bake the recipe
muffin_cupcake_train_preprocessed<-bake(prepped_recipe, muffin_cupcake_train)
muffin_cupcake_train_preprocessed

muffin_cupcake_test_preprocessed<-bake(prepped_recipe,muffin_cupcake_test)
muffin_cupcake_test_preprocessed
