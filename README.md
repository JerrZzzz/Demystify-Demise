# Overview of the Project

This repo contains code and data for analyzing and predicting Dominating Causes of Death from 2001 to 2022. It was created by Zhijun Zhong and Xincheng Zhang. The purpose is to create a report that includes the results of a statistical model that we built in the Model part and try to seek suggestions for citizens and government to improve human happiness. The sections of this repo are data, model, other, paper, and script.

-The Data folder contains the raw data we used in this report and processed data by cleaning, which also includes simulation data. In order to obtain the raw one, visit https://open.alberta.ca/dataset/03339dc5-fb51-4552-97c7-853688fc428d/resource/3e241965-fee3-400e-9652-07cfbf0c0bda/download/deaths-leading-causes.csv to download the dataset in CSV form. 

-The Model folder contains the cleaned dataset we used to build the Model.

-The Other folder contains four sub-files related to writing this report.

  --The literature folder contains five PDF files, which are the relevant literature we used in the entire report.
  --The llms folder contains a llms.tex, which is the full documentation of using chatgpt-4.
  --The plots folder contains two photo format files：
    ---causeofdeath.jpg is the plot we sketch in the Result part.
    ---model.jpg is the plot we build in the Model part. 
  --The sketch folder contains a pdf file which is the simulated dataset and graph in both the Model and Result part. 

-The Paper folder contains the four files about the report and supporting material.
  --The datasheet_template.qmd is the thorough datasheet for the dataset that was constructed. 
  --The Demystify Demise. qmd is the paper in the qmd form.
  --The Demystify-Demise.pdf is the paper in the pdf form.
  --The ref. bib contains all of our references, from libraries in R to articles from the internet.

-The Script folder contains R scripts that are used to produce paper. These are:
  --The 00_simulationdata.R is the simulation for the case.
  --The 01_downloaddata.R is the process of downloading the dataset from the website of https://open.alberta.ca/opendata/leading-causes-of-death#detailed
  --The 02_cleandata.R is the clean for raw data. 
  --The 03_Plotdata.R is the code for sketching the line graph in the Result part. 
  --The 04_modeldata.R is the code for building two different models in the Model part. 
  --The 05_testdata.R is the test for all datasets including the simulated case. 

-LLM Using 

--LLMs folder contained in the LLM usage. In this project, we used AI tools like Chatgpt-4 to help us modify and create the code. All chats can be found in the llms.tex in the Other folder.  

