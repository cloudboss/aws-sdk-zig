const std = @import("std");

pub const AuthType = enum {
    three_legged_oauth,
    two_legged_oauth,
    service_account,

    pub const json_field_names = .{
        .three_legged_oauth = "THREE_LEGGED_OAUTH",
        .two_legged_oauth = "TWO_LEGGED_OAUTH",
        .service_account = "SERVICE_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .three_legged_oauth => "THREE_LEGGED_OAUTH",
            .two_legged_oauth => "TWO_LEGGED_OAUTH",
            .service_account => "SERVICE_ACCOUNT",
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
