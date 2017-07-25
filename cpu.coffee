

#number of bars
ARRAYSIZE=39

#do you want colors? if false all bars are colorOne, so change that color.
colors=true

#colors for the bars, currently it matches my color scheme. you probably want to change these
colorOne="rgb(50,39,72)"
colorTwo="rgb(43,86,114)"
colorThree="rgb(49,168,150)"
colorFour="rgb(185,214,102)"

#don't touch plz, this is the array used to store all the values
Values=(0 for num in [0..ARRAYSIZE])

#You can replace this command with anything that will return a number. this one is for cpu.
#it should return 0-100 so that the colors work properly
command: "ps -A -o %cpu | awk '{s+=$1} END {print s}'"

#refresh frequency, one second curently, changing it is fine, though it can cost extra cpu to change it to, say, 10ms (it looks really cool though...).
refreshFrequency: 1000

render: ->"""
"""+("<div class=\"bar graph#{val}\"></div>" for val in [0..ARRAYSIZE]).toString().replace /,/g,""


update:(output,domEl) ->
  Values=[output].concat Values[0..-2]
  for x in [0..ARRAYSIZE]
    element=$(domEl).find(".graph"+x)
    Value=Values[x]*1
    element.css("width",Value+"px") 
    if !colors && Value!=0
      element.css("border-color",colorOne)
      continue
    if Value==0
      continue
    else if Value<25
      element.css("border-color",colorOne)
    else if Value<50
      element.css("border-color",colorTwo)
    else if Value<75
      element.css("border-color",colorThree)
    else
      element.css("border-color",colorFour)

#change the style as you want
style: """
  left: .1%
  top: 0%

  .bar{
    border: 2px solid rgba(0,0,0,0)
    border-radius:10px
    margin-top:5px
    width: 0px
    height: 7px
  }
  """

