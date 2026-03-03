const std = @import("std");

pub const PutMetricsErrorCode = enum {
    metric_limit_exceeded,
    internal_error,
    validation_error,
    conflict_error,

    pub const json_field_names = .{
        .metric_limit_exceeded = "METRIC_LIMIT_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .conflict_error = "CONFLICT_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metric_limit_exceeded => "METRIC_LIMIT_EXCEEDED",
            .internal_error => "INTERNAL_ERROR",
            .validation_error => "VALIDATION_ERROR",
            .conflict_error => "CONFLICT_ERROR",
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
