const std = @import("std");

/// Error codes for failed report generation.
pub const ReportGenerationErrorCode = enum {
    insufficient_permissions,
    configuration_error,
    internal_error,

    pub const json_field_names = .{
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
        .configuration_error = "CONFIGURATION_ERROR",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_permissions => "INSUFFICIENT_PERMISSIONS",
            .configuration_error => "CONFIGURATION_ERROR",
            .internal_error => "INTERNAL_ERROR",
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
