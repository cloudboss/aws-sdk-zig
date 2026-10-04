const std = @import("std");

pub const DeliveryStreamEncryptionStatus = enum {
    enabled,
    enabling,
    enabling_failed,
    disabled,
    disabling,
    disabling_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .enabling_failed = "ENABLING_FAILED",
        .disabled = "DISABLED",
        .disabling = "DISABLING",
        .disabling_failed = "DISABLING_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .enabling => "ENABLING",
            .enabling_failed => "ENABLING_FAILED",
            .disabled => "DISABLED",
            .disabling => "DISABLING",
            .disabling_failed => "DISABLING_FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
