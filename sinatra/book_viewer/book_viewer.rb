require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @contents = File.readlines "data/toc.txt"
end

helpers do
  def in_paragraphs(chapter_text)
    array = chapter_text.split(/\n\n/)
    array.map! do |paragraph|
      index = array.index(paragraph)
      "<p id=p#{index}>" + paragraph + "</p>"
    end
    array.join
  end
  
  def each_chapter
    @contents.each_with_index do |name, index|
      number = index + 1
      contents = File.read("data/chp#{number}.txt")
      yield number, name, contents
    end
  end
  
  def chapters_matching(query)
    results =[]
    
    return results if !query || query.empty?
    
    each_chapter do |number, name, contents|
      results << {number: number, name: name} if contents.include?(query)
    end
    
    results
  end
  

end

get "/" do
  @title = "The Adventures of CatMan"

  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @contents[number - 1]
  
  redirect "/" unless (1..@contents.size).cover? number
  
  @title = "Chapter #{number}: #{chapter_name}"
  @chapter = File.read "data/chp#{number}.txt"

  erb :chapter
end

get "/search" do
  query = params[:query]
  @results = chapters_matching(query)

  erb :search
end

not_found do
  redirect "/"
end