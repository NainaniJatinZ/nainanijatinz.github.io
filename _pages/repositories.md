---
layout: page
permalink: /experience/
title: experience
description: A list and description of all my professional work experiences.
nav: true
nav_order: 3
---


<div class="profile float-{%- if page.profile.align == 'left' -%}left{%- else -%}right{%- endif -%}">
{% include figure.html 
              path='assets/img/adskate.png' 
              class="img-fluid z-depth-1 rounded"
              caption='June 2022 – August 2022'
              alt=page.profile.image -%}
</div>

## AdSkate, Pittsburgh, U.S.
#### Software Engineering Intern (Remote)  
- Worked on Multilingual Article Categorization using Word Embeddings and Ensemble models to reduce the workload on the server from large-scale transformer models.
- Cleaned and analyzed large text data of articles and news with hierarchical categories with spaCy and NLTK.
- Deployed end-to-end APIs for web scraping, model benchmarking, and more with Flask and Heroku. 


<br>

<div class="profile float-right">
{% include figure.html 
              path='assets/img/kjsce.jpg' 
              class="img-fluid z-depth-1 rounded"
              caption='December 2021 – February 2022'
              alt=page.profile.image -%}
</div>

## K.J. Somaiya College of Engineering, Mumbai, India 
#### Research Intern 
- Created Deep Learning based approach to detect Parkinson’s disease from 3D MRI images of the brain. 
- Preprocessed and augmented 3D MRI images from PPMI with TensorFlow to prepare the dataset for optimal training.
- Performed skull extraction on the sliced images of MRI using BrainSuite to boost the model’s performance. 



<br>

<div class="profile float-right">
{% include figure.html 
              path='assets/img/tkr.jpg' 
              class="img-fluid z-depth-1 rounded"
              caption='July 2020 – December 2020'
              alt=page.profile.image -%}
</div>

## Team KJSCE Robocon, Mumbai, India  
#### Research Intern 
- Implemented PID tuning and Path Planning on a drone in Gazebo with ROS and OpenCV.
- Explored SLAM implementation on the BOT using LIDAR and Binocular vision.
- Trained Juniors in the field of Computer Vision and MATLAB Simulations.



<!-- ## GitHub users

{% if site.data.repositories.github_users %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for user in site.data.repositories.github_users %}
    {% include repository/repo_user.html username=user %}
  {% endfor %}
</div>
{% endif %}

---

## GitHub Repositories

{% if site.data.repositories.github_repos %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in site.data.repositories.github_repos %}
    {% include repository/repo.html repository=repo %}
  {% endfor %}
</div>
{% endif %} -->
