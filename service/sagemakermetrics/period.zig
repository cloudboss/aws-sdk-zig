const std = @import("std");

pub const Period = enum {
    one_minute,
    five_minute,
    one_hour,
    iteration_number,

    pub const json_field_names = .{
        .one_minute = "OneMinute",
        .five_minute = "FiveMinute",
        .one_hour = "OneHour",
        .iteration_number = "IterationNumber",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_minute => "OneMinute",
            .five_minute => "FiveMinute",
            .one_hour => "OneHour",
            .iteration_number => "IterationNumber",
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
