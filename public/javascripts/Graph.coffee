class Graph

  searchElem: (elemText) ->
    $('title:contains('+elemText+')').parent()

  searchLine: (source, target) ->
    searchLineWithCord prepareCord @searchElem(source), @searchElem(target);

  focus: (source, target) ->
    extendedFocus @searchElem(source)[0], @searchLine(source, target)[0], @searchElem(target)[0]

  extendedFocus = (source, line, target) ->    
    changeColor source, "#ff0"
    
    lineEvent = () ->
      changeColor source, "#555"
      changeColor line, "#ff0"
      
      targetEvent = () ->
        changeColor line, "#555"
        changeColor target, "#ff0"
        
        endEvent = () ->
          changeColor target, "#555"

        setTimeout endEvent, 100
    
      setTimeout targetEvent, 100
    
    setTimeout lineEvent, 100

  changeColor = (elem, color) ->
    elem.style.stroke = color
    elem.style.fill = color

  getLine = (x1, x2, y1, y2) ->
    $('line[x1="'+x1+'"][x2="'+x2+'"][y1="'+y1+'"][y2="'+y2+'"]')

  prepareCord = (source, target) ->
    cord =
      x1: source.attr 'cx'
      x2: target.attr 'cx'
      y1: source.attr 'cy'
      y2: target.attr 'cy'
    cord

  getProposition = (x1, x2, y1, y2) ->
    if getLine(x1, x2, y1, y2).length > 0
      getLine x1, x2, y1, y2

  getProposition1 = (cord) ->
    getProposition cord.x1, cord.x2, cord.y1, cord.y2

  getProposition2 = (cord) ->
    getProposition cord.x2, cord.x1, cord.y1, cord.y2

  getProposition3 = (cord) ->
    getProposition cord.x1, cord.x2, cord.y2, cord.y1

  getProposition4 = (cord) ->
    getProposition cord.x2, cord.x1, cord.y2, cord.y1

  searchLineWithCord = (cord) ->
    switch
      when getProposition1 cord then getProposition1 cord
      when getProposition2 cord then getProposition2 cord
      when getProposition3 cord then getProposition3 cord
      when getProposition4 cord then getProposition4 cord
      else null

app.factory "Graph", -> new Graph()