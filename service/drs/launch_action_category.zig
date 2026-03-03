const std = @import("std");

/// Launch action category.
pub const LaunchActionCategory = enum {
    monitoring,
    validation,
    configuration,
    security,
    other,

    pub const json_field_names = .{
        .monitoring = "MONITORING",
        .validation = "VALIDATION",
        .configuration = "CONFIGURATION",
        .security = "SECURITY",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .monitoring => "MONITORING",
            .validation => "VALIDATION",
            .configuration => "CONFIGURATION",
            .security => "SECURITY",
            .other => "OTHER",
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
