const std = @import("std");

/// A reason code for a capacity provider that is not in the `READY` state.
/// Possible values:
///
/// * `VALIDATION_ERROR` – A configuration error prevented the operation. For
///   example, missing permissions, invalid parameters, or a naming conflict.
/// * `QUOTA_EXCEEDED` – An Amazon EC2 resource quota was exceeded. Request a
///   limit increase or remove unused resources.
/// * `THROTTLED` – The request was throttled. Retry after a short delay.
/// * `INTERNAL_SERVER_EXCEPTION` – An internal error occurred.
pub const CapacityProviderStatusCode = enum {
    validation_error,
    quota_exceeded,
    throttled,
    internal_server_exception,

    pub const json_field_names = .{
        .validation_error = "VALIDATION_ERROR",
        .quota_exceeded = "QUOTA_EXCEEDED",
        .throttled = "THROTTLED",
        .internal_server_exception = "INTERNAL_SERVER_EXCEPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation_error => "VALIDATION_ERROR",
            .quota_exceeded => "QUOTA_EXCEEDED",
            .throttled => "THROTTLED",
            .internal_server_exception => "INTERNAL_SERVER_EXCEPTION",
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
