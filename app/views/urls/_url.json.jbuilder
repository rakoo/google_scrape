json.extract! url, :id, :url
json.isTopAd @url.isTopAd == true
json.isRightAd @url.isRightAd == true
json.keyword @url.keyword, :id, :keyword, :processed_at, :total_results, :search_time
json.url url_url(url, format: :json)
