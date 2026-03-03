const PolicyAttributeDescription = @import("policy_attribute_description.zig").PolicyAttributeDescription;

/// Information about a policy.
pub const PolicyDescription = struct {
    /// The policy attributes.
    policy_attribute_descriptions: ?[]const PolicyAttributeDescription = null,

    /// The name of the policy.
    policy_name: ?[]const u8 = null,

    /// The name of the policy type.
    policy_type_name: ?[]const u8 = null,
};
