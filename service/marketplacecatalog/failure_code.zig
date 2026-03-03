const std = @import("std");

pub const FailureCode = enum {
    client_error,
    server_fault,

    pub const json_field_names = .{
        .client_error = "CLIENT_ERROR",
        .server_fault = "SERVER_FAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_error => "CLIENT_ERROR",
            .server_fault => "SERVER_FAULT",
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
