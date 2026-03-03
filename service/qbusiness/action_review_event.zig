const aws = @import("aws");

const ActionReviewPayloadField = @import("action_review_payload_field.zig").ActionReviewPayloadField;
const PluginType = @import("plugin_type.zig").PluginType;

/// An output event that Amazon Q Business returns to an user who wants to
/// perform a plugin action during a streaming chat conversation. It contains
/// information about the selected action with a list of possible user input
/// fields, some pre-populated by Amazon Q Business.
pub const ActionReviewEvent = struct {
    /// The identifier of the conversation with which the action review event is
    /// associated.
    conversation_id: ?[]const u8 = null,

    /// Field values that an end user needs to provide to Amazon Q Business for
    /// Amazon Q Business to perform the requested plugin action.
    payload: ?[]const aws.map.MapEntry(ActionReviewPayloadField) = null,

    /// A string used to retain information about the hierarchical contexts within
    /// an action review event payload.
    payload_field_name_separator: ?[]const u8 = null,

    /// The identifier of the plugin associated with the action review event.
    plugin_id: ?[]const u8 = null,

    /// The type of plugin.
    plugin_type: ?PluginType = null,

    /// The identifier of an Amazon Q Business AI generated associated with the
    /// action review event.
    system_message_id: ?[]const u8 = null,

    /// The identifier of the conversation with which the plugin action is
    /// associated.
    user_message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .payload = "payload",
        .payload_field_name_separator = "payloadFieldNameSeparator",
        .plugin_id = "pluginId",
        .plugin_type = "pluginType",
        .system_message_id = "systemMessageId",
        .user_message_id = "userMessageId",
    };
};
