return {
  ---@param messages ChatMessage[]
  ---@param config ChatConfig
  chat = function(messages, config)
    if #messages < 1 then
      error('Need at least one message')
    end

    local first_msg = messages[1]
    local prompt = 'User:'
      .. (config.system and config.system .. '\n' or '')
      .. first_msg.content
      .. '<|im_end|>'

    for i, msg in ipairs(messages) do
      if i > 1 then
        prompt = prompt
          .. (msg.role == 'user' and 'User:' or 'Assistant:')
          .. msg.content
          .. '<|im_end|>'
      end
    end

    prompt = prompt .. 'Assistant: '

    return {
      prompt = prompt,
      raw = true,
    }
  end,
}
