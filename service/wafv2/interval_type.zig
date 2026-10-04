const std = @import("std");

pub const IntervalType = enum {
    minutely,
    five_minutely,
    hourly,
    daily,

    pub const json_field_names = .{
        .minutely = "MINUTELY",
        .five_minutely = "FIVE_MINUTELY",
        .hourly = "HOURLY",
        .daily = "DAILY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .minutely => "MINUTELY",
            .five_minutely => "FIVE_MINUTELY",
            .hourly => "HOURLY",
            .daily => "DAILY",
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
