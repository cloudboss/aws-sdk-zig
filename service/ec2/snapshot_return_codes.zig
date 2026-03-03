const std = @import("std");

pub const SnapshotReturnCodes = enum {
    success,
    warn_skipped,
    error_missing_permissions,
    error_code_internal_error,
    error_code_client_error,

    pub const json_field_names = .{
        .success = "success",
        .warn_skipped = "skipped",
        .error_missing_permissions = "missing-permissions",
        .error_code_internal_error = "internal-error",
        .error_code_client_error = "client-error",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "success",
            .warn_skipped => "skipped",
            .error_missing_permissions => "missing-permissions",
            .error_code_internal_error => "internal-error",
            .error_code_client_error => "client-error",
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
