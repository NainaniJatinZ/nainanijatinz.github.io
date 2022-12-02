---
layout: page
title: Investing Assistant
description: Curated feature space and environment for RL agent 
img: assets/img/RL.jpg
importance: 2
category: General
---
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
    {% include repository/repo.html repository= 'NainaniJatinZ/investing-assistant' %}
</div> 

In this work, we present a novel environment for cryptocurrencies with specifically curated features. To demonstrate, we focus on Bitcoin as its a leading currency, but the environment and agent can be used for others as well. 
We adhere to two primary objectives - Visualize current market situation and Generate Action Recommendations for Trader.
To be successful we need to consider: Important Price Indicators, User Sentiments, Trader Specific Market Position. And this is all to create optimized recommendations to maximize risk adjusted returns over a long period of time, which we define to be around 1-2 years. 
So, we opt for an investing assistant which will help the investor to gain perspective of the overall market situation and hence plan their investments in Bitcoin.
Investing Assistant, NOT a Trading Bot.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/InvestingAssistant.png" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

This is the flow of our solution. Live BTC data is fetched, then our technical indicators are calculated to understand the trends in data. We also present a sentiment score through tweets about BTC. This feature space is fed to the Reinforcement learning agent to learn on and present its recommendations to the user. The user also receives the visualizations and score of the features to explain the recommendations.

- The research presented a feature space rich enough to model the complicated and volatile trading environment 
- A novel method to model the Bull Market Support Band was also investigated to help the Agent in understanding the market
- The solution aimed to offer assistance to user through its suggestions and generate profit in the long term
- It also gives user relevant information about the decision suggested so that the user can understand the context 

It performed a technical analysis with trend indicators and sentiment analysis of the market on Twitter and was deployed on a website using Flask, Streamlit, and Heroku. I implemented a generalized environment for the agent to simulate its actions and learn. This included feature selection, model structuring, and appropriate rewards. I researched technical analysis through pattern recognition and trend indicators to improve the feature space. I have also authored a research paper on the same, which is accepted at the 2th International Conference on Intelligent Vision and Computing 2022. Through this project, I was able to apply my knowledge in ML to the field of finance.  