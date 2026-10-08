const std = @import("std");

pub const ErrorCode = enum {
    authorization_error,
    resource_not_found_error,
    service_quota_exceeded_error,
    internal_service_error,

    pub const json_field_names = .{
        .authorization_error = "AUTHORIZATION_ERROR",
        .resource_not_found_error = "RESOURCE_NOT_FOUND_ERROR",
        .service_quota_exceeded_error = "SERVICE_QUOTA_EXCEEDED_ERROR",
        .internal_service_error = "INTERNAL_SERVICE_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authorization_error => "AUTHORIZATION_ERROR",
            .resource_not_found_error => "RESOURCE_NOT_FOUND_ERROR",
            .service_quota_exceeded_error => "SERVICE_QUOTA_EXCEEDED_ERROR",
            .internal_service_error => "INTERNAL_SERVICE_ERROR",
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
