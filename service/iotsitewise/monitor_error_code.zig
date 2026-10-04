const std = @import("std");

pub const MonitorErrorCode = enum {
    internal_failure,
    validation_error,
    limit_exceeded,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .validation_error = "VALIDATION_ERROR",
        .limit_exceeded = "LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_failure => "INTERNAL_FAILURE",
            .validation_error => "VALIDATION_ERROR",
            .limit_exceeded => "LIMIT_EXCEEDED",
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
