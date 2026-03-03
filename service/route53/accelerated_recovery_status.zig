const std = @import("std");

pub const AcceleratedRecoveryStatus = enum {
    enabling,
    enable_failed,
    enabling_hosted_zone_locked,
    enabled,
    disabling,
    disable_failed,
    disabled,
    disabling_hosted_zone_locked,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enable_failed = "ENABLE_FAILED",
        .enabling_hosted_zone_locked = "ENABLING_HOSTED_ZONE_LOCKED",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disable_failed = "DISABLE_FAILED",
        .disabled = "DISABLED",
        .disabling_hosted_zone_locked = "DISABLING_HOSTED_ZONE_LOCKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "ENABLING",
            .enable_failed => "ENABLE_FAILED",
            .enabling_hosted_zone_locked => "ENABLING_HOSTED_ZONE_LOCKED",
            .enabled => "ENABLED",
            .disabling => "DISABLING",
            .disable_failed => "DISABLE_FAILED",
            .disabled => "DISABLED",
            .disabling_hosted_zone_locked => "DISABLING_HOSTED_ZONE_LOCKED",
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
