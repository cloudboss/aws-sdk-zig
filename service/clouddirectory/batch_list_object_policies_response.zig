/// Represents the output of a ListObjectPolicies response operation.
pub const BatchListObjectPoliciesResponse = struct {
    /// A list of policy `ObjectIdentifiers`, that are attached to the
    /// object.
    attached_policy_ids: ?[]const []const u8,

    /// The pagination token.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .attached_policy_ids = "AttachedPolicyIds",
        .next_token = "NextToken",
    };
};
