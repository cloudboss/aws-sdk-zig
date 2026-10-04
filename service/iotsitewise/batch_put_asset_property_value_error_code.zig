const std = @import("std");

pub const BatchPutAssetPropertyValueErrorCode = enum {
    resource_not_found_exception,
    invalid_request_exception,
    internal_failure_exception,
    service_unavailable_exception,
    throttling_exception,
    limit_exceeded_exception,
    conflicting_operation_exception,
    timestamp_out_of_range_exception,
    access_denied_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .invalid_request_exception = "InvalidRequestException",
        .internal_failure_exception = "InternalFailureException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .throttling_exception = "ThrottlingException",
        .limit_exceeded_exception = "LimitExceededException",
        .conflicting_operation_exception = "ConflictingOperationException",
        .timestamp_out_of_range_exception = "TimestampOutOfRangeException",
        .access_denied_exception = "AccessDeniedException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found_exception => "ResourceNotFoundException",
            .invalid_request_exception => "InvalidRequestException",
            .internal_failure_exception => "InternalFailureException",
            .service_unavailable_exception => "ServiceUnavailableException",
            .throttling_exception => "ThrottlingException",
            .limit_exceeded_exception => "LimitExceededException",
            .conflicting_operation_exception => "ConflictingOperationException",
            .timestamp_out_of_range_exception => "TimestampOutOfRangeException",
            .access_denied_exception => "AccessDeniedException",
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
