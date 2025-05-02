-- this file will only be used to check if a event is valid for the 
-- new_eventlistener function but it's intended to help
-- with the new_eventlistener function
-- so that you know what you might possibly use 

return {
    -- Message Events
    "MESSAGE_CREATE",
    "MESSAGE_UPDATE",
    "MESSAGE_DELETE",
    "MESSAGE_DELETE_BULK",
    "MESSAGE_REACTION_ADD",
    "MESSAGE_REACTION_REMOVE",
    "MESSAGE_REACTION_REMOVE_ALL",
    "MESSAGE_REACTION_REMOVE_EMOJI",

    -- Guild Events
    "GUILD_CREATE",
    "GUILD_UPDATE",
    "GUILD_DELETE",
    "GUILD_BAN_ADD",
    "GUILD_BAN_REMOVE",
    "GUILD_EMOJIS_UPDATE",
    "GUILD_STICKERS_UPDATE",
    "GUILD_INTEGRATIONS_UPDATE",
    "GUILD_MEMBER_ADD",
    "GUILD_MEMBER_REMOVE",
    "GUILD_MEMBER_UPDATE",
    "GUILD_MEMBERS_CHUNK",
    "GUILD_ROLE_CREATE",
    "GUILD_ROLE_UPDATE",
    "GUILD_ROLE_DELETE",
    "GUILD_SCHEDULED_EVENT_CREATE",
    "GUILD_SCHEDULED_EVENT_UPDATE",
    "GUILD_SCHEDULED_EVENT_DELETE",
    "GUILD_SCHEDULED_EVENT_USER_ADD",
    "GUILD_SCHEDULED_EVENT_USER_REMOVE",

    -- Channel Events
    "CHANNEL_CREATE",
    "CHANNEL_UPDATE",
    "CHANNEL_DELETE",
    "CHANNEL_PINS_UPDATE",
    "THREAD_CREATE",
    "THREAD_UPDATE",
    "THREAD_DELETE",
    "THREAD_LIST_SYNC",
    "THREAD_MEMBER_UPDATE",
    "THREAD_MEMBERS_UPDATE",

    -- Voice & Presence Events
    "VOICE_STATE_UPDATE",
    "VOICE_SERVER_UPDATE",
    "PRESENCE_UPDATE",
    "TYPING_START",

    -- Interaction Events
    "INTERACTION_CREATE",
    "APPLICATION_COMMAND_PERMISSIONS_UPDATE",

    -- Moderation Events
    "AUTO_MODERATION_RULE_CREATE",
    "AUTO_MODERATION_RULE_UPDATE",
    "AUTO_MODERATION_RULE_DELETE",
    "AUTO_MODERATION_ACTION_EXECUTION",

    -- Integration Events
    "INTEGRATION_CREATE",
    "INTEGRATION_UPDATE",
    "INTEGRATION_DELETE",

    -- Invite Events
    "INVITE_CREATE",
    "INVITE_DELETE",

    -- Entitlement Events
    "ENTITLEMENT_CREATE",
    "ENTITLEMENT_UPDATE",
    "ENTITLEMENT_DELETE",

    -- User & Webhook Events
    "USER_UPDATE",
    "WEBHOOKS_UPDATE",
}

