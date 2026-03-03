const std = @import("std");

pub const RedisAuthTypeValue = enum {
    none,
    auth_role,
    auth_token,

    pub const json_field_names = .{
        .none = "none",
        .auth_role = "auth-role",
        .auth_token = "auth-token",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .auth_role => "auth-role",
            .auth_token => "auth-token",
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
