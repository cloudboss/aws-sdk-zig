const PolicyAttributeTypeDescription = @import("policy_attribute_type_description.zig").PolicyAttributeTypeDescription;

/// Information about a policy type.
pub const PolicyTypeDescription = struct {
    /// A description of the policy type.
    description: ?[]const u8,

    /// The description of the policy attributes associated with the policies
    /// defined by Elastic Load Balancing.
    policy_attribute_type_descriptions: ?[]const PolicyAttributeTypeDescription,

    /// The name of the policy type.
    policy_type_name: ?[]const u8,
};
