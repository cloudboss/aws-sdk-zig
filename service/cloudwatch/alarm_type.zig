pub const AlarmType = enum {
    composite_alarm,
    metric_alarm,

    pub const json_field_names = .{
        .composite_alarm = "CompositeAlarm",
        .metric_alarm = "MetricAlarm",
    };
};
