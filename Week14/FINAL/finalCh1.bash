#!/bin/bash

IOCWebpage="10.0.17.6/IOC.html"

function scrapeIOCPage()
{
 #empty files we are about to use
 :> rawHtml.txt
 :> IOC.txt

 curl -s "$IOCWebpage" > rawHtml.txt
 cat rawHtml.txt | pup 'table tr td:first-of-type text{}' > IOC.txt

 rm rawHtml.txt
}

scrapeIOCPage
