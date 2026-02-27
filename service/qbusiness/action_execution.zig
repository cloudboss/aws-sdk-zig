const aws = @import("aws");

const ActionExecutionPayloadField = @import("action_execution_payload_field.zig").ActionExecutionPayloadField;

/// Performs an Amazon Q Business plugin action during a non-streaming chat
/// conversation.
pub const ActionExecution = struct {
    /// A mapping of field names to the field values in input that an end user
    /// provides to Amazon Q Business requests to perform their plugin action.
    payload: []const aws.map.MapEntry(ActionExecutionPayloadField),

    /// A string used to retain information about the hierarchical contexts within
    /// an action execution event payload.
    payload_field_name_separator: []const u8,

    /// The identifier of the plugin the action is attached to.
    plugin_id: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .payload_field_name_separator = "payloadFieldNameSeparator",
        .plugin_id = "pluginId",
    };
};
