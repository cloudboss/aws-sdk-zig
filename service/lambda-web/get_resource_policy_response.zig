/// Contains the resource-based policy and its revision ID.
pub const GetResourcePolicyResponse = struct {
    /// The JSON-formatted resource-based policy attached to the web function.
    policy: []const u8,

    /// The revision ID of the policy.
    revision_id: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .revision_id = "revisionId",
    };
};
