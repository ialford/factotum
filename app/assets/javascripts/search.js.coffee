jQuery ($) ->
  searchContainers = $(".find-resources .search-container")

  if searchContainers.length > 0
    window.googleBibkeys = {}

    searchContainers.each ->
      searchContainer = $(this)
      resultsContainer = searchContainer.find('.search-results')
      $.getJSON searchContainer.data('target'), (data) ->
        records = data.records
        searchContainer.find('.results-count').text(records.length)
        searchContainer.find('.total-count').text(data.size)
        searchContainer.find('.search-term').text(data.search_term)
        searchContainer.find('a.search-link').attr('href', data.search_url)
        currentBibkeys = []
        $.each records, (index,record) ->
          resultsContainer.append(buildRecord(record))
          bibkey = setGoogleBibkey(record)
          if bibkey
            currentBibkeys.push bibkey
        if currentBibkeys.length > 0
          getGoogleBooksData(currentBibkeys)

    buildRecord = (record) ->
      container = $('#recordTemplate .record').clone()
      container.attr('id',record.id)
      container.addClass("record-#{record.primo.display.type}")
      title = $('<a></a>')
      title.attr('href', record.links.detail_url)
      title.html(record.display.title)
      container.find('.title').append(title)
      container.find('.author').html(record.display.creator_contributor)
      container.find('.details').html(record.primo.display.ispartof)
      container.find('.publisher').html(record.display.publisher_provider)
      container.find('.cover-type').html(displayType(record))
      container.find('.availability-library').html(availabilityLibrary(record))
      container.find('.availability-text').html(availabilityText(record))
      if isAvailable(record)
        container.find('.availability-text').addClass('available')
      if record.links.access_url
        link = $('<a></a>')
        link.attr('href',record.links.access_url)
        link.attr('target', '_blank')
        link.html("Access Online")
        container.find('.availability-link').append(link)
      container

    # Make use of the Client-side API from https://developers.google.com/books/docs/dynamic-links
    setGoogleBibkey = (record) ->
      bibData = record.openurl
      if bibData.oclcid
        bibkey = "OCLC:#{bibData.oclcid}"
      else if bibData.isbn
        bibkey = "ISBN:#{bibData.isbn}"
      if bibkey
        window.googleBibkeys[bibkey] = record.id
      bibkey

    getGoogleBooksData = (bibkeys) ->
      url = "http://books.google.com/books?bibkeys=#{bibkeys.join(',')}&jscmd=viewapi&callback=googleBooksCallback"
      $.getScript(url)

    window.googleBooksCallback = (results) ->
      $.each results, (index,result) ->
        recordID = window.googleBibkeys[result.bib_key]
        if recordID && result.thumbnail_url
          image = $('<img>')
          image.attr('src',result.thumbnail_url)
          $("##{recordID} .cover-image").append(image)

    availabilityLibrary = (record) ->
      displayString = null
      libraries = record.holdings
      selectedLibrary = libraries[0]
      $.each libraries, (index,library) ->
        if library["availability_status_code"] == "available"
          selectedLibrary = library
      if selectedLibrary
        displayString = "#{displayLibrary(selectedLibrary.library_code)} #{selectedLibrary.collection} #{selectedLibrary.call_number}"
      displayString

    isAvailable = (record) ->
      if record.primo.display.availpnx == 'available'
        true
      else if record.electronic && record.fulltext_available
        true
      else
        false

    availabilityText = (record) ->
      if record.electronic
        if isAvailable(record)
          "Online access available"
        else
          "See FindText for options"
      else if record.primo.display.availpnx == 'available'
        "Available"
      else
        record.primo.display.availpnx

    displayLibrary = (libraryCode) ->
      libraryCode

    displayType = (record) ->
      string = record.primo.display.type
      string = string.replace "_", " "
      # Capitalize the first letter
      string = string.replace /^[a-z]/, (letter) ->
        letter.toUpperCase()
      string
