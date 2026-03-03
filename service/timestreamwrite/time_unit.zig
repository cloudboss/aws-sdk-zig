const std = @import("std");

pub const TimeUnit = enum {
    milliseconds,
    seconds,
    microseconds,
    nanoseconds,

    pub const json_field_names = .{
        .milliseconds = "MILLISECONDS",
        .seconds = "SECONDS",
        .microseconds = "MICROSECONDS",
        .nanoseconds = "NANOSECONDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .milliseconds => "MILLISECONDS",
            .seconds => "SECONDS",
            .microseconds => "MICROSECONDS",
            .nanoseconds => "NANOSECONDS",
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
