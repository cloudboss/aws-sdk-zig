const std = @import("std");

pub const ActionsSuppressedBy = enum {
    wait_period,
    extension_period,
    alarm,

    pub const json_field_names = .{
        .wait_period = "WaitPeriod",
        .extension_period = "ExtensionPeriod",
        .alarm = "Alarm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wait_period => "WaitPeriod",
            .extension_period => "ExtensionPeriod",
            .alarm => "Alarm",
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
