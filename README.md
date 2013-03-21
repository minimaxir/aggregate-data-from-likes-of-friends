aggregate-data-from-likes-of-friends
====================================

## Summary

This R code calculates the # of Facebook Likes for brand pages for each of the specified users' friends on Facebooks using its Graph API, aggregates it by the Name and Category of the page, and outputs two .csvs: one for Name, and one for Category (+ a bonus bar chart!). The purpose of this is to identify which pages and which types of pages are most frequently of your friends in order to see what is most likely to contribute towards your Suggested Post News Feed spam.

The code does not tabulate likes from friends who have made their likes non-visible to you.

## Prerequisites

1. The RJSONIO R library
2. The username of the person whose friends are being analyzed
3. A valid access token for that user with the friends_likes permission. (go to http://developers.facebook.com/tools/explorer/ , select "Get Access Token," enable the "friends_likes" permission, and use the token that is generated)
