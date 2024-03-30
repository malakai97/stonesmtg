---
layout: page
title: Results
cover: /assets/images/banner_1.jpg
permalink: /results/
---

<div class="home">

    <div class="clearfix">
      {% assign results = site.results | reverse %}
      {% for post in results %}
        <a href="{{ post.url | prepend: site.baseurl }}">
          <div class="event-sqaure"
            style="background-image:url({{site.cdn_url}}{{post.cover | default: default_event_cover}});">
            <h2>{{ post.title }} <span>{{ post.date | date: "%b %-d, %Y" }}</span></h2>
            <div class='event-square-overlay'></div>
          </div>
        </a>
      {% endfor %}
    </div>

</div>
