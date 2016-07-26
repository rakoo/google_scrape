json.extract! keyword, :id, :keyword, :processed_at, :total_results, :search_time
json.urls @keyword.urls do |url|
  json.extract! url, :id, :url
  json.isTopAd url.isTopAd == true
  json.isRightAd url.isRightAd == true
end
json.url keyword_url(keyword, format: :json)
