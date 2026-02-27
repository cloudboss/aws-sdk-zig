/// Contains information about the quick connect configuration settings for a
/// user. The contact flow must be of type
/// Transfer to Agent.
pub const UserQuickConnectConfig = struct {
    /// The identifier of the flow.
    contact_flow_id: []const u8,

    /// The identifier of the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .contact_flow_id = "ContactFlowId",
        .user_id = "UserId",
    };
};
