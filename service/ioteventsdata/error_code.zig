const std = @import("std");

pub const ErrorCode = enum {
    resource_not_found_exception,
    invalid_request_exception,
    internal_failure_exception,
    service_unavailable_exception,
    throttling_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .invalid_request_exception = "InvalidRequestException",
        .internal_failure_exception = "InternalFailureException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .throttling_exception = "ThrottlingException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found_exception => "ResourceNotFoundException",
            .invalid_request_exception => "InvalidRequestException",
            .internal_failure_exception => "InternalFailureException",
            .service_unavailable_exception => "ServiceUnavailableException",
            .throttling_exception => "ThrottlingException",
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
