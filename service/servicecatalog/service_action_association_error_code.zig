const std = @import("std");

pub const ServiceActionAssociationErrorCode = enum {
    duplicate_resource_exception,
    internal_failure,
    limit_exceeded_exception,
    resource_not_found_exception,
    throttling_exception,
    invalid_parameter_exception,

    pub const json_field_names = .{
        .duplicate_resource_exception = "DUPLICATE_RESOURCE",
        .internal_failure = "INTERNAL_FAILURE",
        .limit_exceeded_exception = "LIMIT_EXCEEDED",
        .resource_not_found_exception = "RESOURCE_NOT_FOUND",
        .throttling_exception = "THROTTLING",
        .invalid_parameter_exception = "INVALID_PARAMETER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_resource_exception => "DUPLICATE_RESOURCE",
            .internal_failure => "INTERNAL_FAILURE",
            .limit_exceeded_exception => "LIMIT_EXCEEDED",
            .resource_not_found_exception => "RESOURCE_NOT_FOUND",
            .throttling_exception => "THROTTLING",
            .invalid_parameter_exception => "INVALID_PARAMETER",
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
