# COVID19-AI-CT-Scan-Detection

The model used by this application is a fine-tuned EfficientNet-Lite4 Model provided by TensorFlow Hub making it fast to run on mobile devices. 
I have trained this model for a total of 12789 images from the following datasets below achieving a testing accuracy of 97.32%. 

![Confusion_Matrix](/images/confusion_matrix.png)


![covid_detection](/images/covid_infected.png)
![non_covid_detection](/images/covid_not_infected.png)
![non_informative](/images/not_informative.png)



# Datasets used

https://github.com/mr7495/COVID-CTset

https://www.kaggle.com/azaemon/preprocessed-ct-scans-for-covid19


# Disclaimer:

The A.I. model used to run this application hasn't been tested on 'real world data' but only on open anonymized datasets online. Please bear that in mind when using this application.

