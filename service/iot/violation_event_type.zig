const std = @import("std");

pub const ViolationEventType = enum {
    in_alarm,
    alarm_cleared,
    alarm_invalidated,

    pub const json_field_names = .{
        .in_alarm = "in-alarm",
        .alarm_cleared = "alarm-cleared",
        .alarm_invalidated = "alarm-invalidated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_alarm => "in-alarm",
            .alarm_cleared => "alarm-cleared",
            .alarm_invalidated => "alarm-invalidated",
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
