################## Imports ##############################
# Importing in each cell because of the kernel restarts.
import scrapy
import re
from scrapy.crawler import CrawlerProcess
import numpy as np
import pandas as pd
from pandas.io.json import json_normalize

################### Create Crawler ######################

class GlassdoorSpider(scrapy.Spider):
    # Naming the spider is important if you are running more than one spider of
    # this class simultaneously.
    name = "Glassdoor_Simple"

    # URL(s) to start with.
    start_urls = [
        'https://www.glassdoor.com/Interview/Facebook-Interview-Questions-E40772.htm?filter.jobTitleFTS=Data+Scientist',
    ]

    # Use XPath to parse the response we get.
    def parse(self, response):

        # Iterate over every review class element on the page.
        # Get all the reviews objects for the page

        #Extract the different infomration
        for review in response.xpath('//*[starts-with(@id, "InterviewReview_")]'):


            # Yield a dictionary with the values we want.
            yield {
                # This is the code to choose what we want to extract
                # You can modify this with other Xpath expressions to extract other information from the site
                'interview_questions': review.xpath('.//div[3]/div/div[2]/div[2]/div/div/ul/li/span/text()').extract(),
              'answers' : review.xpath('.//div[3]/div/div[2]/div[2]/div/div/ul/li/span/a/text()').extract(),
                'answer_links' : review.xpath('.//div[3]/div/div[2]/div[2]/div/div/ul/li/span/a/@href').extract(),
                'helpful': review.xpath('.//div[4]/div/div[3]/span/@data-count').extract_first(),
            }

        next_page = response.xpath('//*[@id="FooterPageNav"]/div[2]/ul/li[7]/a/@href').extract()
        if next_page:
            next_page = next_page[0]
            next_page_url = 'https://www.glassdoor.com' + next_page
            print(next_page_url)
            # Request the next page and recursively parse it the same way we did above
            yield scrapy.Request(next_page_url, callback=self.parse)

# Tell the script how to run the crawler by passing in settings.
process = CrawlerProcess({
    'FEED_FORMAT': 'json',         # Store data in JSON format.
    'FEED_URI': 'data.json',  # Name our storage file.
    'LOG_ENABLED': False ,          # Turn off logging for now.
    'ROBOTSTXT_OBEY': True,
    'USER_AGENT': 'BrandynAdderleyCrawler (madderle@gmail.com)',
    'AUTOTHROTTLE_ENABLED': True,
    'HTTPCACHE_ENABLED': True
})

# Start the crawler with our spider.
process.crawl(GlassdoorSpider)
process.start()
print('Success!')

####################### Build DataFrame ###############################
# Turn into DataFrame
glassdoor_df = pd.read_json('data.json', orient='records')
glassdoor_df.head()
