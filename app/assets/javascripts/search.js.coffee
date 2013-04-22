jQuery ($) ->
  searchContainers = $(".find-resources .search-container")

  if searchContainers.length > 0
    window.googleBibkeys = {}

    searchContainers.each ->
      searchContainer = $(this)
      resultsContainer = searchContainer.find('.search-results')
      $.getJSON searchContainer.data('target'), (data) ->
        resultsContainer.html('')
        records = data.records
        searchContainer.find('.results-count').text(records.length)
        searchContainer.find('.total-count').text(data.size)
        searchContainer.find('.search-term').text(data.search_term)
        searchContainer.find('a.search-link').attr('href', data.search_url)
        $.each records, (index,record) ->
          resultsContainer.append(buildRecord(record))
        if data.google_books
          $.each data.google_books.ids, (bibkey,id) ->
            window.googleBibkeys[bibkey] = id
          $.getScript(data.google_books.url)

    buildRecord = (record) ->
      container = $('#recordTemplate .record').clone()
      container.attr('id',record.id)
      container.addClass("record-#{record.type}")
      title = $('<a></a>')
      title.attr('href', record.links.detail_url)
      title.html(record.display.title)
      container.find('.title').append(title)
      container.find('.author').html(record.display.creator_contributor)
      container.find('.details').html(record.display.details)
      container.find('.publisher').html(record.display.publisher_provider)
      container.find('.cover-type').html(record.display.type)
      container.find('.availability-library').html(record.display.available_library)
      container.find('.availability-text').html(record.display.availability)
      if isAvailable(record)
        container.find('.availability-text').addClass('available')
      if record.links.fulltext_url
        link = $('<a></a>')
        link.attr('href',record.links.fulltext_url)
        link.attr('target', '_blank')
        link.html(record.links.fulltext_url_name)
        container.find('.availability-link').append(link)
      container

    # Make use of the Client-side API from https://developers.google.com/books/docs/dynamic-links
    window.googleBooksCallback = (results) ->
      $.each results, (index,result) ->
        recordID = window.googleBibkeys[result.bib_key]
        if recordID && result.thumbnail_url
          image = $('<img>')
          image.attr('src',result.thumbnail_url)
          $("##{recordID} .cover-image").append(image)

    isAvailable = (record) ->
      record.physical_available || record.fulltext_available
