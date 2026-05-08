const LinkedAccountDeveloperJwt = @import("linked_account_developer_jwt.zig").LinkedAccountDeveloperJwt;
const LinkedAccountEmail = @import("linked_account_email.zig").LinkedAccountEmail;
const LinkedAccountOAuth2 = @import("linked_account_o_auth_2.zig").LinkedAccountOAuth2;
const LinkedAccountSms = @import("linked_account_sms.zig").LinkedAccountSms;

/// Represents different linkedAccounts that can be linked to an embedded
/// wallet.
/// This union supports multiple linkedAccount approaches: email, SMS, JWT, and
/// OAuth2.
pub const LinkedAccount = union(enum) {
    /// Developer JWT linkedAccount with key ID and subject
    developer_jwt: ?LinkedAccountDeveloperJwt,
    /// Email-based linkedAccount
    email: ?LinkedAccountEmail,
    /// OAuth2 provider linkedAccount (Google, Apple, X, Telegram, GitHub)
    o_auth_2: ?LinkedAccountOAuth2,
    /// SMS-based linkedAccount using phone number
    sms: ?LinkedAccountSms,

    pub const json_field_names = .{
        .developer_jwt = "developerJwt",
        .email = "email",
        .o_auth_2 = "oAuth2",
        .sms = "sms",
    };
};
