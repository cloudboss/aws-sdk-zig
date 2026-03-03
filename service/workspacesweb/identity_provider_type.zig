const std = @import("std");

pub const IdentityProviderType = enum {
    saml,
    facebook,
    google,
    login_with_amazon,
    sign_in_with_apple,
    oidc,

    pub const json_field_names = .{
        .saml = "SAML",
        .facebook = "Facebook",
        .google = "Google",
        .login_with_amazon = "LoginWithAmazon",
        .sign_in_with_apple = "SignInWithApple",
        .oidc = "OIDC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .saml => "SAML",
            .facebook => "Facebook",
            .google => "Google",
            .login_with_amazon => "LoginWithAmazon",
            .sign_in_with_apple => "SignInWithApple",
            .oidc => "OIDC",
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
