const SecurityServiceType = @import("security_service_type.zig").SecurityServiceType;

/// Defines the policy types that the specified Firewall Manager administrator
/// can manage.
pub const PolicyTypeScope = struct {
    /// Allows the specified Firewall Manager administrator to manage all Firewall
    /// Manager policy types, except for third-party policy types. Third-party
    /// policy types can only be managed by the Firewall Manager default
    /// administrator.
    all_policy_types_enabled: bool = false,

    /// The list of policy types that the specified Firewall Manager administrator
    /// can manage.
    policy_types: ?[]const SecurityServiceType = null,

    pub const json_field_names = .{
        .all_policy_types_enabled = "AllPolicyTypesEnabled",
        .policy_types = "PolicyTypes",
    };
};
