const std = @import("std");

pub const CustomerActionName = enum {
    snooze,
    enable,
    disable,
    acknowledge,
    reset,

    pub const json_field_names = .{
        .snooze = "SNOOZE",
        .enable = "ENABLE",
        .disable = "DISABLE",
        .acknowledge = "ACKNOWLEDGE",
        .reset = "RESET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .snooze => "SNOOZE",
            .enable => "ENABLE",
            .disable => "DISABLE",
            .acknowledge => "ACKNOWLEDGE",
            .reset => "RESET",
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
