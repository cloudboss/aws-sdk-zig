const std = @import("std");

pub const AuthFactorType = enum {
    password,
    email_otp,
    sms_otp,
    web_authn,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .email_otp = "EMAIL_OTP",
        .sms_otp = "SMS_OTP",
        .web_authn = "WEB_AUTHN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .password => "PASSWORD",
            .email_otp => "EMAIL_OTP",
            .sms_otp => "SMS_OTP",
            .web_authn => "WEB_AUTHN",
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
