const std = @import("std");

pub const AlarmType = enum {
    metric,
    composite,
    canary,
    logs,
    event,

    pub const json_field_names = .{
        .metric = "Metric",
        .composite = "Composite",
        .canary = "Canary",
        .logs = "Logs",
        .event = "Event",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metric => "Metric",
            .composite => "Composite",
            .canary => "Canary",
            .logs => "Logs",
            .event => "Event",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
