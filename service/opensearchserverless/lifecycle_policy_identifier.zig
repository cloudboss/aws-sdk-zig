const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// The unique identifiers of policy types and policy names.
pub const LifecyclePolicyIdentifier = struct {
    /// The name of the lifecycle policy.
    name: []const u8,

    /// The type of lifecycle policy.
    type: LifecyclePolicyType,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
