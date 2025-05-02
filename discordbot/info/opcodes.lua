return {
    DISPATCH = 0, -- Events like MESSAGE_CREATE, READY
    HEARTBEAT = 1, -- To keep connection alive
    IDENTIFY = 2, -- Start a new session
    PRESENCEUPDATE = 3, -- Update clients presence
    VOICESTATEUPDATE = 4, -- Join/move/leave voice channels
    RESUME = 6, -- Resume a previous session (after reconnect)
    RECONNECT = 7, -- Server tells client to reconnect and resume 
    REQUESTGUILDMEMBERS = 8, -- Request a list of guild members
    INVALIDSESSION = 9, -- Sent when a session is invalidated
    HELLO = 10, -- Sent by the server to client to let client know it's ready to receive events
    HEARTBEATACK = 11, -- Sent by the client to server to let server know it's alive
}