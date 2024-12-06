-- lua/model/format/ollamachat.lua

return {
  ---@param messages ChatMessage[]
  ---@param config ChatConfig
  chat = function(messages, config)
    if #messages < 1 then
      error('Need at least one message')
    end

    local messages = {}
    local max_messages = math.min(5, #messages)

    for i = #messages - max_messages + 1, #messages do
      local msg = messages[i]
      table.insert(messages, { role = 'user', content = msg.content })
    end

    return {
      formatted_messages = messages,
      raw = true,
    }
  end,
}

