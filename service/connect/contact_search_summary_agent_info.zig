/// Information about the agent who accepted the contact.
pub const ContactSearchSummaryAgentInfo = struct {
    /// The timestamp when the contact was connected to the agent.
    connected_to_agent_timestamp: ?i64 = null,

    /// The identifier of the agent who accepted the contact.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .connected_to_agent_timestamp = "ConnectedToAgentTimestamp",
        .id = "Id",
    };
};
