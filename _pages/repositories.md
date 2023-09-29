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
              caption='Jan 2023 – Jul 2023'
              alt=page.profile.image -%}
</div>

## [AdSkate, Pittsburgh, U.S.](https://www.adskate.com/)
#### Machine Learning Research Intern (Remote)  
- Automated video analysis of 100+ advertisements, leveraging Google Cloud, OpenAI APIs, and custom models, resulting in a 70\% reduction in manual analysis time. 
- Built multi-modal data processing, including text translation, categorization, and keyframe analysis, utilizing LLMs and Vision Transformers, improving data processing efficiency by 25\%. 
- Streamlined image analysis using ViLT Visual Question Answering Model and a custom algorithm, eliminating manual labeling and data entry, streamlining ad analysis workflow. 

<br>

<div class="profile float-{%- if page.profile.align == 'left' -%}left{%- else -%}right{%- endif -%}">
{% include figure.html 
              path='assets/img/adskate.png' 
              class="img-fluid z-depth-1 rounded"
              caption='Jun 2022 – Aug 2022'
              alt=page.profile.image -%}
</div>

## [AdSkate, Pittsburgh, U.S.](https://www.adskate.com/)
#### Software Engineering Intern (Remote)  
- Worked on Multilingual Article Categorization using Word Embeddings and Ensemble models to reduce the workload on the server from large-scale transformer models.
- Cleaned and analyzed large text data of articles and news with hierarchical categories with spaCy and NLTK.
- Deployed end-to-end APIs for web scraping, model benchmarking, and more with Flask and Heroku. 


<br>

<div class="profile float-right">
{% include figure.html 
              path='assets/img/kjsce.jpg' 
              class="img-fluid z-depth-1 rounded"
              caption='Dec 2021 – Feb 2022'
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
              caption='Jul 2020 – Dec 2020'
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
