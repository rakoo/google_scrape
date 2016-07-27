json.partial! "reports/report", report: @report
json.keywords @report.keywords do |keyword|
  json.keyword keyword.keyword
  json.processed_at keyword.processed_at
  json.total_results keyword.total_results
  json.urls keyword.urls do |url|
    json.extract! url, :id, :url
    json.isTopAd url.isTopAd == true
    json.isRightAd url.isRightAd == true
  end
end
