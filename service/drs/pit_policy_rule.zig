const PITPolicyRuleUnits = @import("pit_policy_rule_units.zig").PITPolicyRuleUnits;

/// A rule in the Point in Time (PIT) policy representing when to take snapshots
/// and how long to retain them for.
pub const PITPolicyRule = struct {
    /// Whether this rule is enabled or not.
    enabled: ?bool = null,

    /// How often, in the chosen units, a snapshot should be taken.
    interval: i32,

    /// The duration to retain a snapshot for, in the chosen units.
    retention_duration: i32,

    /// The ID of the rule.
    rule_id: i64 = 0,

    /// The units used to measure the interval and retentionDuration.
    units: PITPolicyRuleUnits,

    pub const json_field_names = .{
        .enabled = "enabled",
        .interval = "interval",
        .retention_duration = "retentionDuration",
        .rule_id = "ruleID",
        .units = "units",
    };
};
