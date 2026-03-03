const ConversationRetentionSettings = @import("conversation_retention_settings.zig").ConversationRetentionSettings;
const RoomRetentionSettings = @import("room_retention_settings.zig").RoomRetentionSettings;

/// The retention settings for an Amazon Chime Enterprise account that determine
/// how long to retain items such as chat-room messages and chat-conversation
/// messages.
pub const RetentionSettings = struct {
    /// The chat conversation retention settings.
    conversation_retention_settings: ?ConversationRetentionSettings = null,

    /// The chat room retention settings.
    room_retention_settings: ?RoomRetentionSettings = null,

    pub const json_field_names = .{
        .conversation_retention_settings = "ConversationRetentionSettings",
        .room_retention_settings = "RoomRetentionSettings",
    };
};
