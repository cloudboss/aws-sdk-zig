const std = @import("std");

pub const ErrorDetails = enum {
    validation,
    service_quota_exceeded,
    access_denied,
    resource_not_found,
    throttling,
    internal_service_exception,
    cancelled,
    user_recoverable,

    pub const json_field_names = .{
        .validation = "The inputs to this request are invalid.",
        .service_quota_exceeded = "Service limits have been exceeded.",
        .access_denied = "Missing required permission to perform this request.",
        .resource_not_found = "One or more inputs to this request were not found.",
        .throttling = "The system temporarily lacks sufficient resources to process the request.",
        .internal_service_exception = "An internal error has occurred.",
        .cancelled = "Cancelled",
        .user_recoverable = "A user recoverable error has occurred",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation => "The inputs to this request are invalid.",
            .service_quota_exceeded => "Service limits have been exceeded.",
            .access_denied => "Missing required permission to perform this request.",
            .resource_not_found => "One or more inputs to this request were not found.",
            .throttling => "The system temporarily lacks sufficient resources to process the request.",
            .internal_service_exception => "An internal error has occurred.",
            .cancelled => "Cancelled",
            .user_recoverable => "A user recoverable error has occurred",
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
