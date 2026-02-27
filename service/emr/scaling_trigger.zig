const CloudWatchAlarmDefinition = @import("cloud_watch_alarm_definition.zig").CloudWatchAlarmDefinition;

/// The conditions that trigger an automatic scaling activity.
pub const ScalingTrigger = struct {
    /// The definition of a CloudWatch metric alarm. When the defined alarm
    /// conditions are met
    /// along with other trigger parameters, scaling activity begins.
    cloud_watch_alarm_definition: CloudWatchAlarmDefinition,

    pub const json_field_names = .{
        .cloud_watch_alarm_definition = "CloudWatchAlarmDefinition",
    };
};
