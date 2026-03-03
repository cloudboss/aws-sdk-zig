const std = @import("std");

pub const ErrorCode = enum {
    dependency_access_denied_error,
    dependency_throttling_error,
    dependency_service_error,
    service_quota_not_available_error,

    pub const json_field_names = .{
        .dependency_access_denied_error = "DEPENDENCY_ACCESS_DENIED_ERROR",
        .dependency_throttling_error = "DEPENDENCY_THROTTLING_ERROR",
        .dependency_service_error = "DEPENDENCY_SERVICE_ERROR",
        .service_quota_not_available_error = "SERVICE_QUOTA_NOT_AVAILABLE_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dependency_access_denied_error => "DEPENDENCY_ACCESS_DENIED_ERROR",
            .dependency_throttling_error => "DEPENDENCY_THROTTLING_ERROR",
            .dependency_service_error => "DEPENDENCY_SERVICE_ERROR",
            .service_quota_not_available_error => "SERVICE_QUOTA_NOT_AVAILABLE_ERROR",
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
