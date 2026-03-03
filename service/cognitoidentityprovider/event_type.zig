const std = @import("std");

pub const EventType = enum {
    sign_in,
    sign_up,
    forgot_password,
    password_change,
    resend_code,

    pub const json_field_names = .{
        .sign_in = "SignIn",
        .sign_up = "SignUp",
        .forgot_password = "ForgotPassword",
        .password_change = "PasswordChange",
        .resend_code = "ResendCode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sign_in => "SignIn",
            .sign_up => "SignUp",
            .forgot_password => "ForgotPassword",
            .password_change => "PasswordChange",
            .resend_code => "ResendCode",
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
