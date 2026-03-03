const std = @import("std");

pub const PeriodAlignment = enum {
    end_time,
    start_time,

    pub const json_field_names = .{
        .end_time = "END_TIME",
        .start_time = "START_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end_time => "END_TIME",
            .start_time => "START_TIME",
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
