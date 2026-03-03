const std = @import("std");

pub const FastLaunchStateCode = enum {
    enabling,
    enabling_failed,
    enabled,
    enabled_failed,
    disabling,
    disabling_failed,

    pub const json_field_names = .{
        .enabling = "enabling",
        .enabling_failed = "enabling-failed",
        .enabled = "enabled",
        .enabled_failed = "enabled-failed",
        .disabling = "disabling",
        .disabling_failed = "disabling-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "enabling",
            .enabling_failed => "enabling-failed",
            .enabled => "enabled",
            .enabled_failed => "enabled-failed",
            .disabling => "disabling",
            .disabling_failed => "disabling-failed",
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
