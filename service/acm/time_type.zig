const std = @import("std");

pub const TimeType = enum {
    minutes,
    hours,
    days,

    pub const json_field_names = .{
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .minutes => "MINUTES",
            .hours => "HOURS",
            .days => "DAYS",
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
