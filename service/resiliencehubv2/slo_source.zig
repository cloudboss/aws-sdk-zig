const PolicyValueSource = @import("policy_value_source.zig").PolicyValueSource;

/// Contains the effective availability SLO value and its source.
pub const SloSource = struct {
    policy_name: ?[]const u8 = null,

    /// Indicates whether the value comes from the service's own account or a
    /// cross-account policy.
    source: ?PolicyValueSource = null,

    /// The availability SLO percentage value.
    value: ?f64 = null,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .source = "source",
        .value = "value",
    };
};
