const PolicyValueSource = @import("policy_value_source.zig").PolicyValueSource;

/// Contains the effective disaster recovery approach value for a service.
pub const DisasterRecoverySource = struct {
    policy_name: ?[]const u8 = null,

    /// Indicates whether the value comes from the service's own account or a
    /// cross-account policy.
    source: ?PolicyValueSource = null,

    /// The disaster recovery approach value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .source = "source",
        .value = "value",
    };
};
