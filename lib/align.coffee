module.exports =
  align: () ->
    return unless editor = atom.workspace.getActiveTextEditor()
    selection = editor.getLastSelection()
    text = selection.getText()
    widthByToken = []
    tokensByRow = []
    atToken = false
    currentWidth = 0
    currentRow = []
    currentColumn = 0
    currentToken = ""
    # parse tokens
    for c in text
      if atToken
        if c == "\n"
          tokensByRow.push(currentRow)
          currentRow = []
          currentColumn = 0
        else if c != " "
          currentWidth += 1
          currentToken += c
        else
          existingValue = tokensByRow[currentColumn]
          if existingValue == undefined || existingValue < currentWidth
            widthByToken[currentColumn] = currentWidth
          currentWidth = 0
          currentColumn += 1
          currentRow.push(currentToken)
          currentToken = ""
          atToken = false
      else
        if c != " "
          currentToken += c
          atToken = true
    # pad tokens
    for row in tokensByRow
      for column, index in row
        while column.length < widthByToken[index]
          column += " "
    # join the tokens
    text = ""
    for row in tokensByRow
      text += row.join(" ") + "\n"
    selection.insertText(text)
