const ApplicationPolicyType = @import("application_policy_type.zig").ApplicationPolicyType;

/// Application policies describe what the certificate can be used for.
pub const ApplicationPolicy = union(enum) {
    /// The object identifier (OID) of an application policy.
    policy_object_identifier: ?[]const u8,
    /// The type of application policy
    policy_type: ?ApplicationPolicyType,

    pub const json_field_names = .{
        .policy_object_identifier = "PolicyObjectIdentifier",
        .policy_type = "PolicyType",
    };
};
