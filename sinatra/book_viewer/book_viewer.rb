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
  
  def highlight_query(text, query)
    text_array = text.split(query)
    text_array.join("<strong>#{query}</strong>")
  end
  
  def each_chapter
    @contents.each_with_index do |name, index|
      number = index + 1
      contents = File.read("data/chp#{number}.txt")
      yield number, name, contents
    end
  end
  
=begin
  1. get chapter data  contents = File.read("data/chp#{number}.txt")
  2. divide chapter into an array of paragraphs  (/\n\n/)
  3. create a hash with key being the index in paragraph array + 1 and value being the paragraph (only with matching search)
  4. add to results as part of 2 element subarray [{chapter results}, {paragraph results}]
=end

  def paragraphs_matching(chapter, query)
    results = []
    
    paragraphs = chapter.split(/\n\n/)
    
    paragraphs.each_with_index do |content, index|
      results << {number: index, content: content} if content.include?(query)
    end
    results
  end
  
  def chapters_matching(query)
    results =[]
    
    return results if !query || query.empty?
    
    each_chapter do |number, name, contents|
      if contents.include?(query)
        chapter = {number: number, name: name}
        paragraphs = paragraphs_matching(contents, query)
        results << [chapter, paragraphs] 
      else
        next
      end
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