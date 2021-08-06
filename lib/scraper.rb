require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

	def get_page
		doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
	end

	def get_courses
		self.get_page.css(".post")
	end

	def make_courses
		self.get_courses.each do |post|
			self.make_course(post)
		end
	end

	def make_course(post)
		course = Course.new
		course.title = post.css("h2").text
		course.schedule = post.css(".date").text
		course.description = post.css("p").text
	end
  
	def print_courses
		self.make_courses
		Course.all.each do |course|
			self.print_course(course)
		end
	end

	def print_course(course)
		if course.title && course.title != ""
			puts "Title: #{course.title}"
			puts "  Schedule: #{course.schedule}"
			puts "  Description: #{course.description}"
		end
	end
  
end

Scraper.new.get_page



