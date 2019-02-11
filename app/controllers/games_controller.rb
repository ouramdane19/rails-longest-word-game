require 'json'
require 'open-uri'

class GamesController < ApplicationController

    def isEnglishWord? (word)
        baseUrl ="https://wagon-dictionary.herokuapp.com/" 
        url = baseUrl + "#{word}"
        p url
        user_serialized = open(url).read
         user = JSON.parse(user_serialized)
         return true if user["found"] == true
    end 
   
    def isValidWord?(word,letters)
        #lettresWord = word.split("").to_a
        word.split("").to_a.all? do |lettre|
            letters.to_s.include?(lettre)
    end

    end

    def new
        #genrate a random letters and store him in array ==>@lettres
       @lettres = (0...10).map { (65 + rand(26)).chr }
      
    end

    def score
        @score = 0
        @word = params[:word]
        p isEnglishWord?(@word)
        p isValidWord?(@word,@letters)

        if !isValidWord?(@word,@letters)
            @response = "Sorry but #{@word} can't built out of #{@lettres}" 
        elsif isEnglishWord?(@word)
            @response ="Congratulations ! #{@word} is a valid english word"
        else 
            @response = "Sorry but #{@word} does not seems to be a valid english word"
        end

        if isValidWord?(@word,@letters) && isEnglishWord?(@word) 
            @score +=1 
        end
    end
end


