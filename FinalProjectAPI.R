# FinalProjectAPI.R
# Establish libraries for use
  library(tidyverse)
  library(arm)
  library(dplyr)
  library(caret)
  
#---------- read in raw data and prep it for prediction modeling ----------#
  
  diabetes_df_API <- read.csv("./FinalProjectRawData/diabetes_binary_health_indicators_BRFSS2015.csv")
  
  diabetes_df_API <- as_tibble(diabetes_df_API)
  
  diabetes_df_API <- diabetes_df_API %>%
    filter(BMI >= 13.5) %>%
    filter(BMI <= 50 ) %>%
    dplyr::rename("HasDiabetes" = Diabetes_binary, 
                  "HighCholesterol" = HighChol, 
                  "CholesterolChecked" = CholCheck, 
                  "ConsumesFruits" = Fruits, 
                  "ConsumesVeggies" = Veggies, 
                  "HeavyAlcoholUse" = HvyAlcoholConsump,
                  "HasHealthcare" = AnyHealthcare,
                  "ExpensiveTreatment" = NoDocbcCost,
                  "GeneralHealth" = GenHlth,
                  "BadMentalHealth" = MentHlth,
                  "BadPhysicalHealth" = PhysHlth,
                  "DifficultyWalking" = DiffWalk) |>
    mutate(across(c(1:4, 6:15, 18:22), as.factor))
  
  diabetes_df_API$HasDiabetes <- fct_recode(diabetes_df_API$HasDiabetes, No = "0", Yes = "1")
  diabetes_df_API$HighBP <- fct_recode(diabetes_df_API$HighBP, No = "0", Yes = "1")
  diabetes_df_API$HighCholesterol <- fct_recode(diabetes_df_API$HighCholesterol, No = "0", Yes = "1")
  diabetes_df_API$CholesterolChecked  <- fct_recode(diabetes_df_API$CholesterolChecked, No = "0", Yes = "1")
  diabetes_df_API$Smoker <- fct_recode(diabetes_df_API$Smoker, No = "0", Yes = "1")
  diabetes_df_API$Stroke <- fct_recode(diabetes_df_API$Stroke, No = "0", Yes = "1")
  diabetes_df_API$HeartDiseaseorAttack <- fct_recode(diabetes_df_API$HeartDiseaseorAttack, No = "0", Yes = "1")
  diabetes_df_API$PhysActivity <- fct_recode(diabetes_df_API$PhysActivity, No = "0", Yes = "1")
  diabetes_df_API$ConsumesFruits <- fct_recode(diabetes_df_API$ConsumesFruits, No = "0", Yes = "1")
  diabetes_df_API$ConsumesVeggies <- fct_recode(diabetes_df_API$ConsumesVeggies, No = "0", Yes = "1")
  diabetes_df_API$HeavyAlcoholUse <- fct_recode(diabetes_df_API$HeavyAlcoholUse, No = "0", Yes = "1")
  diabetes_df_API$HasHealthcare <- fct_recode(diabetes_df_API$HasHealthcare, No = "0", Yes = "1")
  diabetes_df_API$ExpensiveTreatment <- fct_recode(diabetes_df_API$ExpensiveTreatment, No = "0", Yes = "1")
  diabetes_df_API$GeneralHealth <- fct_recode(diabetes_df_API$GeneralHealth, Excellent = "1", VeryGood = "2", Good = "3", Fair = "4", Poor = "5")
  diabetes_df_API$DifficultyWalking <- fct_recode(diabetes_df_API$DifficultyWalking, No = "0", Yes = "1")
  diabetes_df_API$Sex <- fct_recode(diabetes_df_API$Sex, Female = "0", Male = "1")
  diabetes_df_API$Age <- fct_recode(diabetes_df_API$Age, Age1="1", Age2="2", Age3="3", Age4="4", Age5="5", Age6="6", Age7="7", Age8="8", Age9="9", Age10="10", Age11="11", Age12="12", Age13="13")
  diabetes_df_API$Education <- fct_recode(diabetes_df_API$Education, Ed1 = "1", Ed2 = "2", Ed3 = "3", Ed4 = "4", Ed5 = "5", Ed6 = "6")
  diabetes_df_API$Income <- fct_recode(diabetes_df_API$Income, Income1 = "1", Income2 = "2", Income3 = "3", Income4 = "4", Income5 = "5", Income6 = "6", Income7 = "7", Income8 = "8")
  
  
#----- fit the data to the selected model -----#
  
  bayesianLogisticFit <- train(HasDiabetes~., 
                                data=diabetes_df_API,
                                method="bayesglm",
                                preProcess=c("center", "scale"),
                                trControl = trainControl(method = "cv",
                                                         number = 5,
                                                         classProbs = TRUE,
                                                         summaryFunction = mnLogLoss)
  )
  
  print(bayesianLogisticFit)

  
  
#---------- generate API ---------- #
  

#* Info
#* @get /info
function(){
  name <- c("Jason M. Pattison, 29-Jul_2024, ST 588-601, SUM I 2024")
  renderedGitHub <- c("https://jpatt1980.github.io/FinalProject/")
  
  print(list("Name, Date, Course"=name, "Rendered GitHub Pages URL"=renderedGitHub))
}
  
  
  
#* BayesianGLM Prediction Model for Diabetes_binary
#* @param HighCholesterol Enter No or Yes
#* @param BMI Enter BMI
#* @param BadPhysicalHealth Enter Number of Days (1 through 30) of Bad Physical Health
#* @param Age Age Category: Options are Age1 through Age13
#* @get /pred
function(HighCholesterol = "No", BMI = 27, BadPhysicalHealth = 0, Age = "Age9"){


}

  #query with http://localhost:PORT/predictionModel?HighCholesterol=No&BMI=27&BadPhysicalHealth=0&Age=Age9
