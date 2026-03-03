const FailoverConditionSettings = @import("failover_condition_settings.zig").FailoverConditionSettings;

/// Failover Condition settings. There can be multiple failover conditions
/// inside AutomaticInputFailoverSettings.
pub const FailoverCondition = struct {
    /// Failover condition type-specific settings.
    failover_condition_settings: ?FailoverConditionSettings = null,

    pub const json_field_names = .{
        .failover_condition_settings = "FailoverConditionSettings",
    };
};
