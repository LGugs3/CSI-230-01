clear
$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.15/ToBeScraped.html

#Deliverable 1(#9)
#$scrapedPage.Links.Count

#Deliverable 2(10)
#$scrapedPage.Links

#Deliv 3(11)
#$scrapedPage.Links | select outerText, href

#$h2s = $scrapedPage.ParsedHtml.body.getElementsByTagName("h2") | select outerText
#Deliv 4(12)
#$h2s

#$div1s = $scrapedPage.ParsedHtml.body.getElementsByTagName("div") | where { `
#$_.getAttributeNode("class").Value -ilike "div-1" } | select innerText
#Deliv 5(13)
#$div1s