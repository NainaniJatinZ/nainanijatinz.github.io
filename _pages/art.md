---
layout: page
title: art
permalink: /art/
description: Drawings, copy studies, and short notes on making things without over-optimizing them.
nav: true
nav_order: 6
---

<div class="art-index-intro">
  <p>
    This is a small public sketch journal. Each entry gets one cover image here, then its own page for
    more photos and a few notes on what I was trying, what I noticed, or why a drawing stuck with me.
  </p>
</div>

{% assign art_entries = site.art | sort: "date" | reverse %}
{% if art_entries.size > 0 %}
  <div class="art-grid">
    {% for piece in art_entries %}
      <article class="art-card">
        <a class="art-card-link" href="{{ piece.url | relative_url }}">
          {% if piece.cover %}
            <div class="art-card-image-wrap">
              <img class="art-card-image" src="{{ piece.cover | relative_url }}" alt="{{ piece.cover_alt | default: piece.title }}">
            </div>
          {% endif %}
          <div class="art-card-body">
            <p class="art-card-date">{{ piece.date | date: "%B %-d, %Y" }}</p>
            <h2 class="art-card-title">{{ piece.title }}</h2>
            {% if piece.description %}
              <p class="art-card-description">{{ piece.description }}</p>
            {% endif %}
          </div>
        </a>
      </article>
    {% endfor %}
  </div>
{% else %}
  <p>No art entries yet.</p>
{% endif %}
