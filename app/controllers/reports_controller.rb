class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @keywords = @report.keywords
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new()

    (report_params[:keywords]||"").lines.each do |keyword|
      keyword.chomp!
      next if keyword.blank?
      k = @report.keywords.build(keyword: keyword)
      search_and_fill(k)
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:report, :keywords)
    end

    def search_and_fill keyword
      # Add some headers to trick Yahoo! into believing we're not a bot
      res = HTTP
        .headers(:accept_language => "fr-FR,fr;q=0.8,en-US;q=0.6,en;q=0.4")
        .headers(:user_agent => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36")
        .headers(:accept => "text/html")
        .headers(:referer => "https://fr.search.yahoo.com/")
        .headers(:authority => "fr.search.yahoo.com")
        .get("https://fr.search.yahoo.com/search?p=#{keyword.keyword}")
      if res.code == 200
        keyword.cache = res.to_s
        d = Oga.parse_html(res.to_s)

        # ads on top
        d.css('div#main div ol li div div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          keyword.urls.build(url: link, isTopAd: true)
        end

        # ads on the right
        d.css('div#right div ol div div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          keyword.urls.build(url: link, isRightAd: true)
        end


        # non-ad links
        d.css('div#web ol li div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          keyword.urls.build(url: link)
        end

        # total results
        keyword.total_results = d.css('div#left div ol li div div span').last.children.first.text.gsub(/[^\d]/, '').to_i
        keyword.processed_at = Time.now.strftime("%FT%T%z")
      end
    end

end
