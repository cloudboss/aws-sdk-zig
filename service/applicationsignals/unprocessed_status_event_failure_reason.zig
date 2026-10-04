const std = @import("std");

/// The reason an instrumentation status event could not be processed.
///
/// * `THROTTLED` - The request exceeded allowed throughput.
/// * `INTERNAL_ERROR` - An internal server error occurred while processing the
///   event.
/// * `VALIDATION_ERROR` - The event failed validation.
pub const UnprocessedStatusEventFailureReason = enum {
    throttled,
    internal_error,
    validation_error,

    pub const json_field_names = .{
        .throttled = "THROTTLED",
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .throttled => "THROTTLED",
            .internal_error => "INTERNAL_ERROR",
            .validation_error => "VALIDATION_ERROR",
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
