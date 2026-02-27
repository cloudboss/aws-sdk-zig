/// Configuration for quick connect.
pub const FlowQuickConnectConfig = struct {
    /// The contact flow ID for the quick connect configuration.
    contact_flow_id: []const u8,

    pub const json_field_names = .{
        .contact_flow_id = "ContactFlowId",
    };
};
