const AlarmCondition = @import("alarm_condition.zig").AlarmCondition;

/// Defines a condition that must be met for a trigger to fire.
pub const TriggerCondition = struct {
    /// The name of the CloudWatch alarm associated with the condition.
    associated_alarm_name: []const u8,

    /// The condition that must be met. Valid values include `green` and `red`.
    condition: AlarmCondition,

    pub const json_field_names = .{
        .associated_alarm_name = "associatedAlarmName",
        .condition = "condition",
    };
};
