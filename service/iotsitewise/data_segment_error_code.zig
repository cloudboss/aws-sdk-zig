const std = @import("std");

pub const DataSegmentErrorCode = enum {
    internal_failure,
    validation_error,
    resource_not_found,
    limit_exceeded,
    conflicting_operation,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .validation_error = "VALIDATION_ERROR",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .conflicting_operation = "CONFLICTING_OPERATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_failure => "INTERNAL_FAILURE",
            .validation_error => "VALIDATION_ERROR",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .limit_exceeded => "LIMIT_EXCEEDED",
            .conflicting_operation => "CONFLICTING_OPERATION",
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
