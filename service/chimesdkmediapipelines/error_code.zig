const std = @import("std");

pub const ErrorCode = enum {
    bad_request,
    forbidden,
    not_found,
    resource_limit_exceeded,
    service_failure,
    service_unavailable,
    throttling,

    pub const json_field_names = .{
        .bad_request = "BadRequest",
        .forbidden = "Forbidden",
        .not_found = "NotFound",
        .resource_limit_exceeded = "ResourceLimitExceeded",
        .service_failure = "ServiceFailure",
        .service_unavailable = "ServiceUnavailable",
        .throttling = "Throttling",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bad_request => "BadRequest",
            .forbidden => "Forbidden",
            .not_found => "NotFound",
            .resource_limit_exceeded => "ResourceLimitExceeded",
            .service_failure => "ServiceFailure",
            .service_unavailable => "ServiceUnavailable",
            .throttling => "Throttling",
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
