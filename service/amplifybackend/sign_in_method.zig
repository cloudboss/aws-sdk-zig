const std = @import("std");

pub const SignInMethod = enum {
    email,
    email_and_phone_number,
    phone_number,
    username,

    pub const json_field_names = .{
        .email = "EMAIL",
        .email_and_phone_number = "EMAIL_AND_PHONE_NUMBER",
        .phone_number = "PHONE_NUMBER",
        .username = "USERNAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email => "EMAIL",
            .email_and_phone_number => "EMAIL_AND_PHONE_NUMBER",
            .phone_number => "PHONE_NUMBER",
            .username => "USERNAME",
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
