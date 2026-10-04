const LinkedAccountDeveloperJwt = @import("linked_account_developer_jwt.zig").LinkedAccountDeveloperJwt;
const LinkedAccountEmail = @import("linked_account_email.zig").LinkedAccountEmail;
const LinkedAccountOAuth2 = @import("linked_account_o_auth_2.zig").LinkedAccountOAuth2;
const LinkedAccountSms = @import("linked_account_sms.zig").LinkedAccountSms;

/// Represents different linked accounts that can be linked to an embedded
/// wallet. Supports email, SMS, JWT, and OAuth2 approaches.
pub const LinkedAccount = union(enum) {
    /// Developer JWT linked account with key ID and subject.
    developer_jwt: ?LinkedAccountDeveloperJwt,
    /// Email-based linked account.
    email: ?LinkedAccountEmail,
    /// OAuth2 provider linked account (Google, Apple, X, Telegram, GitHub).
    o_auth_2: ?LinkedAccountOAuth2,
    /// SMS-based linked account using phone number.
    sms: ?LinkedAccountSms,

    pub const json_field_names = .{
        .developer_jwt = "developerJwt",
        .email = "email",
        .o_auth_2 = "oAuth2",
        .sms = "sms",
    };
};
