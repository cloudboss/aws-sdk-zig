const VoiceConnectorItem = @import("voice_connector_item.zig").VoiceConnectorItem;

/// The Amazon Chime SDK Voice Connector group configuration, including
/// associated Voice Connectors. You can include Voice Connectors from different
/// AWS Regions in a group. This creates a fault tolerant mechanism for
/// fallback in case of availability events.
pub const VoiceConnectorGroup = struct {
    /// The Voice Connector group's creation time stamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The name of a Voice Connector group.
    name: ?[]const u8,

    /// The Voice Connector group's creation time stamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    /// The ARN of the Voice Connector group.
    voice_connector_group_arn: ?[]const u8,

    /// The ID of a Voice Connector group.
    voice_connector_group_id: ?[]const u8,

    /// The Voice Connectors to which you route inbound calls.
    voice_connector_items: ?[]const VoiceConnectorItem,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .name = "Name",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_connector_group_arn = "VoiceConnectorGroupArn",
        .voice_connector_group_id = "VoiceConnectorGroupId",
        .voice_connector_items = "VoiceConnectorItems",
    };
};
