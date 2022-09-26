---
layout: page
title: project 3
description: Advanced Time Series Forecasting for Natural Gas Prices
img: assets/img/SIH.png
redirect: https://unsplash.com
importance: 3
category: Hackathons
---


<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
    {% include repository/repo.html repository= 'NainaniJatinZ/Hack_Inversion-SIH' %}
</div> 

We propose a Machine learning price-forecasting model that takes a more balanced overview at the significant price affecting factors viz. technical indicators (Eg: MACD, EMA, a custom indicator) and real-world factors such as NG production, storage, logistics, and weather data.

We also perform trend analysis on the data by locating the instances of technical patterns.

We have used three types of models (LSTM, Statistical, and SVR) to compare the best forecast. Forecasting is done recursively, feeding predictions to forecast future data. The forecasts are compared with benchmarks through RMSE, M-DM(Multivariate Diebold Mariano test), and AIC(Akaike information criterion).

A Website is also deployed to provide a dashboard for visualizations and forecasted results as output.

In this machine learning model, we are using three independent models, viz., LSTM, Hybrid Statistical model and SVR.

The LSTM model leverages various technical indicators, namely, MACD, 21w EMA, 20w SMA, Custom Index, closing value and volume, in order to accurately forecast Natural Gas prices. We are using CNN LSTM and Encoder-Decoder LSTM model, and the best of these two will be selected.

For hybrid statistical model we are focussing only on closing prices, and for the SVR model 3 day SMA as input to reduce the variance and help capture the non linearity in the price data.