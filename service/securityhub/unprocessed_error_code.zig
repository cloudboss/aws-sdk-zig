const std = @import("std");

pub const UnprocessedErrorCode = enum {
    invalid_input,
    access_denied,
    not_found,
    resource_not_found,
    limit_exceeded,

    pub const json_field_names = .{
        .invalid_input = "INVALID_INPUT",
        .access_denied = "ACCESS_DENIED",
        .not_found = "NOT_FOUND",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .limit_exceeded = "LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_input => "INVALID_INPUT",
            .access_denied => "ACCESS_DENIED",
            .not_found => "NOT_FOUND",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .limit_exceeded => "LIMIT_EXCEEDED",
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
