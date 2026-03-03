const aws = @import("aws");

const ActionReviewPayloadField = @import("action_review_payload_field.zig").ActionReviewPayloadField;
const PluginType = @import("plugin_type.zig").PluginType;

/// An output event that Amazon Q Business returns to an user who wants to
/// perform a plugin action during a non-streaming chat conversation. It
/// contains information about the selected action with a list of possible user
/// input fields, some pre-populated by Amazon Q Business.
pub const ActionReview = struct {
    /// Field values that an end user needs to provide to Amazon Q Business for
    /// Amazon Q Business to perform the requested plugin action.
    payload: ?[]const aws.map.MapEntry(ActionReviewPayloadField) = null,

    /// A string used to retain information about the hierarchical contexts within
    /// an action review payload.
    payload_field_name_separator: ?[]const u8 = null,

    /// The identifier of the plugin associated with the action review.
    plugin_id: ?[]const u8 = null,

    /// The type of plugin.
    plugin_type: ?PluginType = null,

    pub const json_field_names = .{
        .payload = "payload",
        .payload_field_name_separator = "payloadFieldNameSeparator",
        .plugin_id = "pluginId",
        .plugin_type = "pluginType",
    };
};
