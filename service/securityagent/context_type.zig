const std = @import("std");

/// Category of execution context.
pub const ContextType = enum {
    /// Error encountered during execution.
    @"error",
    /// Client-side error encountered during execution.
    client_error,
    /// Warning encountered during execution.
    warning,
    /// Informational message during execution.
    info,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .client_error = "CLIENT_ERROR",
        .warning = "WARNING",
        .info = "INFO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "ERROR",
            .client_error => "CLIENT_ERROR",
            .warning => "WARNING",
            .info => "INFO",
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
