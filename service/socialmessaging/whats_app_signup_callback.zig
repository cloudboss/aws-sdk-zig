/// Contains the `accessToken` provided by Meta during signup.
pub const WhatsAppSignupCallback = struct {
    /// The access token for your WhatsApp Business Account. The `accessToken` value
    /// is provided by Meta.
    access_token: []const u8,

    /// The URL where WhatsApp will send callback notifications for this account.
    callback_url: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .callback_url = "callbackUrl",
    };
};
