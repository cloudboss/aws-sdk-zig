const std = @import("std");

/// Predefined code indicating the error that caused the failure
pub const ProfileOutboundRequestFailureCode = enum {
    /// Unexpected error during processing of request
    unknown_error,
    /// The specified resource was not found
    resource_not_found,
    /// The specified resource conflicts with another resource
    conflict,
    /// Request throttled due to large number of requests
    request_throttled,
    /// The request failed to satisfy the constraints specified by the service
    invalid_input,

    pub const json_field_names = .{
        .unknown_error = "UnknownError",
        .resource_not_found = "ResourceNotFound",
        .conflict = "Conflict",
        .request_throttled = "RequestThrottled",
        .invalid_input = "InvalidInput",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_error => "UnknownError",
            .resource_not_found => "ResourceNotFound",
            .conflict => "Conflict",
            .request_throttled => "RequestThrottled",
            .invalid_input => "InvalidInput",
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
