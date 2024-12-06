-- lua/model/format/ollamachat_test.lua

local function chat(messages, config)
    if #messages < 1 then
        error('Need at least one message')
    end

    local formatted_messages = {}
    local max_messages = math.min(5, #messages)

    for i = #messages - max_messages + 1, #messages do
        local msg = messages[i]
        table.insert(formatted_messages, {role = msg.role, content = msg.content})
    end

    return {
        formatted_messages = formatted_messages,
        raw = true,
    }
end

-- Test case for empty messages array
do
    local status, err = pcall(function()
        chat({}, {})
    end)
    if not status then
        print("Test case 1 failed: " .. err)
    else
        print("Test case 1 passed")
    end
end

-- Test case for a single message
do
    local messages = {{role = 'user', content = 'Hello'}}
    local config = {}
    local result = chat(messages, config)

    if #result.formatted_messages == 1 and result.formatted_messages[1].role == 'user' and result.formatted_messages[1].content == 'Hello' then
        print("Test case 2 passed")
    else
        print("Test case 2 failed")
    end
end

-- Test case for multiple messages
do
    local messages = {
        {role = 'user', content = 'Message 1'},
        {role = 'assistant', content = 'Message 2'},
        {role = 'user', content = 'Message 3'},
        {role = 'assistant', content = 'Message 4'},
        {role = 'user', content = 'Message 5'},
    }
    local config = {}
    local result = chat(messages, config)

    if #result.formatted_messages == #messages then
        local passed = true
        for i, msg in ipairs(result.formatted_messages) do
            if msg.role ~= messages[i].role or msg.content ~= messages[i].content then
                passed = false
                break
            end
        end
        if passed then
            print("Test case 3 passed")
        else
            print("Test case 3 failed")
        end
    else
        print("Test case 3 failed")
    end
end

-- Test case for more than five messages
do
    local messages = {
        {role = 'user', content = 'Message 1'},
        {role = 'assistant', content = 'Message 2'},
        {role = 'user', content = 'Message 3'},
        {role = 'assistant', content = 'Message 4'},
        {role = 'user', content = 'Message 5'},
        {role = 'assistant', content = 'Message 6'},
    }
    local config = {}
    local result = chat(messages, config)

    -- Print the result for debugging
    if #result.formatted_messages == 5 then
        local passed = true
        for i = 2, #messages do
            if result.formatted_messages[i-1].role ~= messages[i].role or result.formatted_messages[i-1].content ~= messages[i].content then
                passed = false
                break
            end
        end
        if passed then
            print("Test case 4 passed")
        else
            print("Test case 4 failed")
        end
    else
        print("Test case 4 failed")
    end
end

print("All tests finished.")