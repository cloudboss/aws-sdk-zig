const std = @import("std");

pub const ErrorCode = enum {
    duplicate_input,
    resource_does_not_exist,
    resource_already_exists,
    internal_server_failure,

    pub const json_field_names = .{
        .duplicate_input = "DUPLICATE_INPUT",
        .resource_does_not_exist = "RESOURCE_DOES_NOT_EXIST",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .internal_server_failure = "INTERNAL_SERVER_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_input => "DUPLICATE_INPUT",
            .resource_does_not_exist => "RESOURCE_DOES_NOT_EXIST",
            .resource_already_exists => "RESOURCE_ALREADY_EXISTS",
            .internal_server_failure => "INTERNAL_SERVER_FAILURE",
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
