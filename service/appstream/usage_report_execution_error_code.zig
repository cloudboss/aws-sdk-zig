const std = @import("std");

pub const UsageReportExecutionErrorCode = enum {
    resource_not_found,
    access_denied,
    internal_service_error,

    pub const json_field_names = .{
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .internal_service_error = "INTERNAL_SERVICE_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .access_denied => "ACCESS_DENIED",
            .internal_service_error => "INTERNAL_SERVICE_ERROR",
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
