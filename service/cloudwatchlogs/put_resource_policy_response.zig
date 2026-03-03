const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyResponse = struct {
    /// The new policy.
    resource_policy: ?ResourcePolicy = null,

    /// The revision ID of the created or updated resource policy. Only returned for
    /// resource-scoped policies.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_policy = "resourcePolicy",
        .revision_id = "revisionId",
    };
};
