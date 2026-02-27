/// For Amazon Chime SDK Voice Connector groups, the Amazon Chime SDK Voice
/// Connectors to which you route inbound calls. Includes priority configuration
/// settings. Limit: 3 VoiceConnectorItems per Voice Connector group.
pub const VoiceConnectorItem = struct {
    /// The priority setting of a Voice Connector item. Calls are routed to hosts
    /// in priority order, with 1 as the highest priority. When hosts have equal
    /// priority,
    /// the system distributes calls among them based on their relative weight.
    priority: i32,

    /// The Voice Connector ID.
    voice_connector_id: []const u8,

    pub const json_field_names = .{
        .priority = "Priority",
        .voice_connector_id = "VoiceConnectorId",
    };
};
