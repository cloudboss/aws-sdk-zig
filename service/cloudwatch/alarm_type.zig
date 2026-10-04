const std = @import("std");

pub const AlarmType = enum {
    composite_alarm,
    metric_alarm,
    log_alarm,

    pub const json_field_names = .{
        .composite_alarm = "CompositeAlarm",
        .metric_alarm = "MetricAlarm",
        .log_alarm = "LogAlarm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .composite_alarm => "CompositeAlarm",
            .metric_alarm => "MetricAlarm",
            .log_alarm => "LogAlarm",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
