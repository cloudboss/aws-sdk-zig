const std = @import("std");

/// A predefined code indicating the error that caused the failure.
pub const FailureCode = enum {
    /// The request failed to satisfy the constraints specified by the service
    invalid_input,
    /// The request was throttled due to excessive usage
    request_throttled,
    /// Unexpected error during processing of request
    unknown_error,
    /// Request throttled due to large number of pending dial requests
    buffer_limit_exceeded,

    pub const json_field_names = .{
        .invalid_input = "InvalidInput",
        .request_throttled = "RequestThrottled",
        .unknown_error = "UnknownError",
        .buffer_limit_exceeded = "BufferLimitExceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_input => "InvalidInput",
            .request_throttled => "RequestThrottled",
            .unknown_error => "UnknownError",
            .buffer_limit_exceeded => "BufferLimitExceeded",
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
