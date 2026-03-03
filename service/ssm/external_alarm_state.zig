const std = @import("std");

pub const ExternalAlarmState = enum {
    unknown,
    alarm,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .alarm = "ALARM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "UNKNOWN",
            .alarm => "ALARM",
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
