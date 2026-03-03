const std = @import("std");

pub const VpcEndpointErrorCode = enum {
    endpoint_not_found,
    server_error,

    pub const json_field_names = .{
        .endpoint_not_found = "ENDPOINT_NOT_FOUND",
        .server_error = "SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .endpoint_not_found => "ENDPOINT_NOT_FOUND",
            .server_error => "SERVER_ERROR",
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
