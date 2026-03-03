const std = @import("std");

pub const DataAccessStatus = enum {
    disabled,
    disabling,
    enabled,
    enabling,
    failed,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .disabling = "Disabling",
        .enabled = "Enabled",
        .enabling = "Enabling",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "Disabled",
            .disabling => "Disabling",
            .enabled => "Enabled",
            .enabling => "Enabling",
            .failed => "Failed",
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
