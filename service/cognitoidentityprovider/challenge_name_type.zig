const std = @import("std");

pub const ChallengeNameType = enum {
    sms_mfa,
    email_otp,
    software_token_mfa,
    select_mfa_type,
    mfa_setup,
    password_verifier,
    custom_challenge,
    select_challenge,
    device_srp_auth,
    device_password_verifier,
    admin_no_srp_auth,
    new_password_required,
    sms_otp,
    password,
    web_authn,
    password_srp,

    pub const json_field_names = .{
        .sms_mfa = "SMS_MFA",
        .email_otp = "EMAIL_OTP",
        .software_token_mfa = "SOFTWARE_TOKEN_MFA",
        .select_mfa_type = "SELECT_MFA_TYPE",
        .mfa_setup = "MFA_SETUP",
        .password_verifier = "PASSWORD_VERIFIER",
        .custom_challenge = "CUSTOM_CHALLENGE",
        .select_challenge = "SELECT_CHALLENGE",
        .device_srp_auth = "DEVICE_SRP_AUTH",
        .device_password_verifier = "DEVICE_PASSWORD_VERIFIER",
        .admin_no_srp_auth = "ADMIN_NO_SRP_AUTH",
        .new_password_required = "NEW_PASSWORD_REQUIRED",
        .sms_otp = "SMS_OTP",
        .password = "PASSWORD",
        .web_authn = "WEB_AUTHN",
        .password_srp = "PASSWORD_SRP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sms_mfa => "SMS_MFA",
            .email_otp => "EMAIL_OTP",
            .software_token_mfa => "SOFTWARE_TOKEN_MFA",
            .select_mfa_type => "SELECT_MFA_TYPE",
            .mfa_setup => "MFA_SETUP",
            .password_verifier => "PASSWORD_VERIFIER",
            .custom_challenge => "CUSTOM_CHALLENGE",
            .select_challenge => "SELECT_CHALLENGE",
            .device_srp_auth => "DEVICE_SRP_AUTH",
            .device_password_verifier => "DEVICE_PASSWORD_VERIFIER",
            .admin_no_srp_auth => "ADMIN_NO_SRP_AUTH",
            .new_password_required => "NEW_PASSWORD_REQUIRED",
            .sms_otp => "SMS_OTP",
            .password => "PASSWORD",
            .web_authn => "WEB_AUTHN",
            .password_srp => "PASSWORD_SRP",
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
