---
layout: page
title: Articles
permalink: /articles/
---

<div class="home">

    <div class="clearfix">
      {% assign articles = site.articles | reverse %}
      {% for post in articles %}
        <a href="{{ post.url | prepend: site.baseurl }}">
          <div class="event-sqaure"
            style="background-image:url({{post.cover | default: default_event_cover}});">
            <h2>{{ post.title }} <span>{{ post.date | date: "%b %-d, %Y" }}</span></h2>
            <div class='event-square-overlay'></div>
          </div>
        </a>
      {% endfor %}
    </div>

</div>
