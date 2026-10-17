const std = @import("std");

/// The type of error that prevented the Cleanup step from deleting output
/// resources. Valid values are:
///
/// * `ClientError` indicates that the failure was caused by the request.
/// * `InternalFailure` indicates that the failure was caused by an internal
///   error.
pub const CleanupFailureErrorCode = enum {
    client_error,
    internal_failure,

    pub const json_field_names = .{
        .client_error = "ClientError",
        .internal_failure = "InternalFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_error => "ClientError",
            .internal_failure => "InternalFailure",
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
