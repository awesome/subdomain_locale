# encoding: UTF-8
ENV["RAILS_ENV"] = "test"

require "isolate/now"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "minitest/autorun"
require "rails/test_help"
Rails.backtrace_cleaner.remove_silencers!

class HelloControllerTest < ActionController::TestCase
  def test_links
    @request.host = "example.com"
    get :world
    menu = css_select("menu a")
    assert_equal "/", menu[0]["href"]
    assert_equal "http://www.example.com/", menu[1]["href"]
    assert_equal "http://ru.example.com/",  menu[2]["href"]
    assert_equal "http://ua.example.com/",  menu[3]["href"]
  end

  def test_default
    @request.host = "www.example.com"
    get :world
    assert_response :ok
    assert_select "p", "Hello"
  end

  def test_direct
    @request.host = "ru.example.com"
    get :world
    assert_response :ok
    assert_select "p", "Привет"
  end

  def test_custom
    @request.host = "ua.example.com"
    get :world
    assert_response :ok
    assert_select "p", "Привіт"
  end

  def test_other
    @request.host = "wtf.example.com"
    assert_raise(I18n::InvalidLocale) do
      get :world
    end
  end
end

class HelloMailerTest < ActionController::TestCase
  def test
    mail = I18n.with_locale(:ru) { HelloMailer.world }
    assert_equal "http://ru.example.com/", mail.body.to_s.lines[3].chomp
  end
end
