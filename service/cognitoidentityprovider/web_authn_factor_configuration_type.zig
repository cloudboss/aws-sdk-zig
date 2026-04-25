const std = @import("std");

/// The configuration of passkey authentication as a single factor or a
/// multi-factor
/// authentication (MFA) method. When set to
/// `MULTI_FACTOR_WITH_USER_VERIFICATION`, your user pool requires passkey
/// authenticators to perform [user
/// verification](https://www.w3.org/TR/webauthn-2/#user-verification), for
/// example a biometric or PIN. User verification combined
/// with the passkey constitutes multi-factor authentication. When set to
/// `SINGLE_FACTOR`, passkeys are a single authentication factor.
pub const WebAuthnFactorConfigurationType = enum {
    single_factor,
    multi_factor_with_user_verification,

    pub const json_field_names = .{
        .single_factor = "SINGLE_FACTOR",
        .multi_factor_with_user_verification = "MULTI_FACTOR_WITH_USER_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_factor => "SINGLE_FACTOR",
            .multi_factor_with_user_verification => "MULTI_FACTOR_WITH_USER_VERIFICATION",
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
