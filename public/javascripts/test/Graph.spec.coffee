describe 'Graph', ->
    
    it 'instance should exist', ->
        expect(graph).not.toEqual null

    it 'should get element get element with label', ->
        seachElem = graph.searchElem 'Elem 1'
        expect(seachElem.attr 'name').toEqual 'elem1'

    it 'should get other element get element with other label', ->
        seachElem = graph.searchElem 'Elem 2'
        expect(seachElem.attr 'name').toEqual 'elem2'

    it 'should get line for two elem name', ->
        searchLine = graph.searchLine 'Elem 1', 'Elem 2'
        expect(searchLine.attr 'name').toEqual 'line1'

    it 'should get other line for two elem name', ->
        searchLine = graph.searchLine 'Elem 1', 'Elem 3'
        expect(searchLine.attr 'name').toEqual 'line2'

    it 'should not return line when connect not exist', ->
        searchLine = graph.searchLine 'Elem 2', 'Elem 3'
        expect(searchLine).toEqual null

    it 'should focus event on elements and line', ->
        runs -> graph.focus 'Elem 1', 'Elem 2'
        waitsFor (-> changedCssEvent.length is 6), 500
        runs -> expectChangedFlow ['elem1', 'line1', 'elem2']

    it 'should focus other event on elements and line', ->
        runs -> graph.focus 'Elem 3', 'Elem 1'
        waitsFor (-> changedCssEvent.length is 6), 500
        runs -> expectChangedFlow ['elem3', 'line2', 'elem1']

    it 'should not focus event where elem is not siblings', ->
        result = graph.focus 'Elem 2', 'Elem 3'
        expect(result).toEqual false

    beforeEach module 'viser'

    beforeEach =>
        # template:
        # Elem 2 --- Elem 1 --- Elem 3
        $('<svg></svg>').appendTo 'body'
        $('<circle name="elem1" class="node" r="60" style="fill: #555555;" cx="596.4415810805936" cy="368.6794786492221"><title>Elem 1</title></circle>').appendTo 'svg'
        $('<circle name="elem2" class="node" r="60" style="fill: #555555;" cx="568.258680122823" cy="177.10789147630857"><title>Elem 2</title></circle>').appendTo 'svg'
        $('<circle name="elem3" class="node" r="60" style="fill: #555555;" cx="478.54668051274814" cy="519.3262410405388"><title>Elem 3</title></circle>').appendTo 'svg'
        $('<line name="line1" class="link" style="stroke-width: 2.449489742783178px;" x1="596.4415810805936" y1="368.6794786492221" x2="568.258680122823" y2="177.10789147630857"></line>').appendTo 'svg'
        $('<line name="line2" class="link" style="stroke-width: 2.449489742783178px;" x1="596.4415810805936" y1="368.6794786492221" x2="478.54668051274814" y2="519.3262410405388"></line>').appendTo 'svg'

    changedCssEvent = []
    origFnCSS = null
    graph = null

    beforeEach =>
        #mock jquery css fn
        origFnCSS = $.fn.css
        $.fn.css = ->
            changedCssEvent.push
                name: this.attr('name')
                flash: 'flashed' == this.attr 'flashed'
            origFnCSS.apply this, arguments

    afterEach =>
        $('svg').remove()
        changedCssEvent = []
        $.fn.css = origFnCSS

    beforeEach =>
        graph = new Graph

    expectChangedFlow = (elems) ->
        elems.forEach (item, i) ->
            expect(changedCssEvent[i * 2]).toEqual { 'name': item, 'flash': true }
            expect(changedCssEvent[i * 2 + 1]).toEqual { 'name': item, 'flash': false }
