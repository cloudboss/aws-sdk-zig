/// StripePrivy configuration - credentials provided by Stripe + Privy
pub const StripePrivyConfigurationInput = struct {
    /// The app ID provided by Privy.
    app_id: []const u8,

    /// The app secret provided by Privy.
    app_secret: []const u8,

    /// The authorization ID for the Stripe Privy integration.
    authorization_id: []const u8,

    /// The authorization private key for the Stripe Privy integration.
    authorization_private_key: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_secret = "appSecret",
        .authorization_id = "authorizationId",
        .authorization_private_key = "authorizationPrivateKey",
    };
};
