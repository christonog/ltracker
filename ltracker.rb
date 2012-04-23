require 'rubygems'
require 'sinatra'

get '/' do
  @title = "Track your package"
  erb :home

end

# Need to add USPS, Canadian Post, and other shipping options

post '/' do
  # UPS code
  if params[:number] =~ /\A1ZW/
   redirect "http://wwwapps.ups.com/WebTracking/processInputRequest?sort_by=status&tracknums_displayed=1&TypeOfInquiryNumber=T&loc=en_US&InquiryNumber1=#{params[:number]}&track.x=0&track.y=0"
  # Australian Air code
  elsif params[:number] =~ /\AUJZ/
    redirect "https://trackandtrace.aae.com.au/#{params[:number]}"
  elsif params[:number] =~ /\d{12}/
    #US Fedex
    redirect "http://www.fedex.com/Tracking?language=english&cntry_code=us&tracknumbers=#{params[:number]}"
  elsif params[:number] =~ /\A00/
    #Fedex UK
    redirect "http://www.fedexuk.net/accounts/QuickTrack.aspx?consignment=#{params[:number]}"
  elsif params[:number] =~ /\d{10}/
    #DPD
    redirect "http://www.dpd.co.uk/tracking/trackingSearch.do?search.searchType=0&search.parcelNumber=#{params[:number]}&search.searchScope="
  elsif params[:number] =~ /\A11/
    #DHL
    redirect "http://track.dhl-usa.com/TrackByNbr.asp?ShipmentNumber=#{params[:number]}"
  else
    "not a valid tracking number. Try again."
  end
end

get '/about' do
  
  @title = "About this App"
  erb :about

end
