/// The service control policies (SCP) action definition details.
pub const ScpActionDefinition = struct {
    /// The policy ID attached.
    policy_id: []const u8,

    /// A list of target IDs.
    target_ids: []const []const u8,

    pub const json_field_names = .{
        .policy_id = "PolicyId",
        .target_ids = "TargetIds",
    };
};
