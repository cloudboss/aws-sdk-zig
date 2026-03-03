const std = @import("std");

pub const DurationType = enum {
    hours,
    minutes,
    seconds,
    milliseconds,
    days,

    pub const json_field_names = .{
        .hours = "hours",
        .minutes = "minutes",
        .seconds = "seconds",
        .milliseconds = "milliseconds",
        .days = "days",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hours => "hours",
            .minutes => "minutes",
            .seconds => "seconds",
            .milliseconds => "milliseconds",
            .days => "days",
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
