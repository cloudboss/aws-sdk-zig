const aws = @import("aws");

const ActionExecutionPayloadField = @import("action_execution_payload_field.zig").ActionExecutionPayloadField;

/// A request from an end user signalling an intent to perform an Amazon Q
/// Business plugin action during a streaming chat.
pub const ActionExecutionEvent = struct {
    /// A mapping of field names to the field values in input that an end user
    /// provides to Amazon Q Business requests to perform their plugin action.
    payload: []const aws.map.MapEntry(ActionExecutionPayloadField),

    /// A string used to retain information about the hierarchical contexts within a
    /// action execution event payload.
    payload_field_name_separator: []const u8,

    /// The identifier of the plugin for which the action is being requested.
    plugin_id: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .payload_field_name_separator = "payloadFieldNameSeparator",
        .plugin_id = "pluginId",
    };
};
