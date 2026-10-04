const std = @import("std");

pub const EventFilterType = enum {
    sign_in,
    password_change,
    sign_up,

    pub const json_field_names = .{
        .sign_in = "SIGN_IN",
        .password_change = "PASSWORD_CHANGE",
        .sign_up = "SIGN_UP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sign_in => "SIGN_IN",
            .password_change => "PASSWORD_CHANGE",
            .sign_up => "SIGN_UP",
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
