class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]

  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.all
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # No edit
  # GET /keywords/1/edit
  #def edit
  #end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)

    fetch(@keyword)

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords/1
  # PATCH/PUT /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'Keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:keyword)
    end

    def fetch keyweord
      # Add some headers to trick Yahoo! into believing we're not a bot
      res = HTTP
        .headers(:accept_language => "fr-FR,fr;q=0.8,en-US;q=0.6,en;q=0.4")
        .headers(:user_agent => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36")
        .headers(:accept => "text/html")
        .headers(:referer => "https://fr.search.yahoo.com/")
        .headers(:authority => "fr.search.yahoo.com")
        .get("https://fr.search.yahoo.com/search?p=#{@keyword.keyword}")
      if res.code == 200
        @keyword.cache = res.to_s
        d = Oga.parse_html(res.to_s)

        # ads on top
        d.css('div#main div ol li div div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          @keyword.urls.build(url: link, isTopAd: true)
        end

        # ads on the right
        d.css('div#right div ol div div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          @keyword.urls.build(url: link, isRightAd: true)
        end


        # non-ad links
        d.css('div#web ol li div div h3 a').each do |ad|
          link = ad.attributes.select {|a| a.name == "href"}.first.value
          @keyword.urls.build(url: link)
        end

        # total results
        @keyword.total_results = d.css('div#left div ol li div div span').last.children.first.text.gsub(/[^\d]/, '').to_i
        @keyword.processed_at = Time.now.strftime("%FT%T%z")
      end
    end
end
