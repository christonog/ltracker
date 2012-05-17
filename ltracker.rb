
require 'sinatra'

def ups_redirect_url(match) 
  redirect "http://wwwapps.ups.com/WebTracking/processInputRequest?sort_by=status&tracknums_displayed=1&TypeOfInquiryNumber=T&loc=en_US&InquiryNumber1=#{match}&track.x=0&track.y=0"
end

def australian_air_redirect_url(match)
  redirect "https://trackandtrace.aae.com.au/#{match}"
end

def fedex_redirect_url(match)
  redirect "http://www.fedex.com/Tracking?language=english&cntry_code=us&tracknumbers=#{match}"
end

def fedexuk_redirect_url(match)
  redirect "http://www.fedexuk.net/accounts/QuickTrack.aspx?consignment=#{match}"
end

def dpd_redirect_url(match)
  redirect "http://www.dpd.co.uk/tracking/trackingSearch.do?search.searchType=0&search.parcelNumber=#{match}&search.searchScope="
end

def dhl_redirect_url(match)
  redirect "http://track.dhl-usa.com/TrackByNbr.asp?ShipmentNumber=#{match}"
end


get '/' do
  @title = "Track your package"
  erb :home
end

# Need to add USPS, Canadian Post, and other shipping options (DHL AU?)

post '/' do

  case 
  
  when params[:number] =~ /\A1ZW/ #UPS

    ups_redirect_url(params[:number])
  
  when params[:number] =~ /\AUJZ/ # Australian Air code

    australian_air_redirect_url(params[:number])

  when params[:number] =~ /(\d{12}|\d{15})/ 
    #US Fedex -- if the number is 12 or 15 digits
    #digits of 20 or 22 are rare, will fix this when they come up

    fedex_redirect_url(params[:number])

  when params[:number] =~ /\A00/ #Fedex UK

    fedexuk_redirect_url(params[:number])

  when params[:number] =~ /\d{10}/ #DPD

    dpd_redirect_url(params[:number])

  when params[:number] =~ /\A11/ #if the number is 11 alphabet characters -- DHL

    dhl_redirect_url(params[:number])    

  else
    erb :try_again
  end
end

get '/about' do
  
  @title = "About this App"
  erb :about

end

not_found do
  halt 404, "Sorry, page not found."
end

# uri = URI.parse("http://www.canadapost.ca/cpotools/apps/track/personal/findByTrackNumber")
# params[:number] = '7310061100142246'
# response = Net::HTTP.post_form(uri, {"id" => "7310061100142246"})
# post 'http://www.canadapost.ca/cpotools/apps/track/personal/findByTrackNumber', params={id: '7310061100142246'}