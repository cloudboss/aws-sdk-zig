const std = @import("std");

/// Error code for pentest job failure.
pub const ErrorCode = enum {
    /// Failure caused by a client-side error.
    client_error,
    /// Failure caused by an internal error.
    internal_error,
    /// Pentest job was stopped by the user.
    stopped_by_user,

    pub const json_field_names = .{
        .client_error = "CLIENT_ERROR",
        .internal_error = "INTERNAL_ERROR",
        .stopped_by_user = "STOPPED_BY_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_error => "CLIENT_ERROR",
            .internal_error => "INTERNAL_ERROR",
            .stopped_by_user => "STOPPED_BY_USER",
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
