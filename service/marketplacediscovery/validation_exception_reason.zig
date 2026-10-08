const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_pagination_token,
    malformed_request_parameters,
    pagination_limit_exceeded,

    pub const json_field_names = .{
        .invalid_pagination_token = "INVALID_PAGINATION_TOKEN",
        .malformed_request_parameters = "MALFORMED_REQUEST_PARAMETERS",
        .pagination_limit_exceeded = "PAGINATION_LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_pagination_token => "INVALID_PAGINATION_TOKEN",
            .malformed_request_parameters => "MALFORMED_REQUEST_PARAMETERS",
            .pagination_limit_exceeded => "PAGINATION_LIMIT_EXCEEDED",
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
