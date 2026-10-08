const PolicyValueSource = @import("policy_value_source.zig").PolicyValueSource;

/// Contains an effective RTO or RPO value and its source.
pub const TargetSource = struct {
    policy_name: ?[]const u8 = null,

    /// Indicates whether the value comes from the service's own account or a
    /// cross-account policy.
    source: ?PolicyValueSource = null,

    /// The RTO or RPO value in minutes.
    value: ?i32 = null,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .source = "source",
        .value = "value",
    };
};
