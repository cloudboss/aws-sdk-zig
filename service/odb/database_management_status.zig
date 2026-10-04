const std = @import("std");

pub const DatabaseManagementStatus = enum {
    enabling,
    enabled,
    disabling,
    not_enabled,
    failed_enabling,
    failed_disabling,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .not_enabled = "NOT_ENABLED",
        .failed_enabling = "FAILED_ENABLING",
        .failed_disabling = "FAILED_DISABLING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "ENABLING",
            .enabled => "ENABLED",
            .disabling => "DISABLING",
            .not_enabled => "NOT_ENABLED",
            .failed_enabling => "FAILED_ENABLING",
            .failed_disabling => "FAILED_DISABLING",
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
