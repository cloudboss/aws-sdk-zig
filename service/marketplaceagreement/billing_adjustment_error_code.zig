const std = @import("std");

pub const BillingAdjustmentErrorCode = enum {
    conflict_exception,
    validation_exception,
    resource_not_found_exception,
    internal_failure,

    pub const json_field_names = .{
        .conflict_exception = "CONFLICT_EXCEPTION",
        .validation_exception = "VALIDATION_EXCEPTION",
        .resource_not_found_exception = "RESOURCE_NOT_FOUND_EXCEPTION",
        .internal_failure = "INTERNAL_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conflict_exception => "CONFLICT_EXCEPTION",
            .validation_exception => "VALIDATION_EXCEPTION",
            .resource_not_found_exception => "RESOURCE_NOT_FOUND_EXCEPTION",
            .internal_failure => "INTERNAL_FAILURE",
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
