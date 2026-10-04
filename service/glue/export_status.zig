const std = @import("std");

/// The current status of the data catalog export.
pub const ExportStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    failed,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "ENABLING",
            .enabled => "ENABLED",
            .disabling => "DISABLING",
            .disabled => "DISABLED",
            .failed => "FAILED",
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
