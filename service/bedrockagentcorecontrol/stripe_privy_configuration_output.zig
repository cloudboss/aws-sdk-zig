const Secret = @import("secret.zig").Secret;

/// StripePrivy configuration output with secret ARNs
pub const StripePrivyConfigurationOutput = struct {
    /// The app ID provided by Privy.
    app_id: []const u8,

    app_secret_arn: Secret,

    /// The authorization ID for the Stripe Privy integration.
    authorization_id: []const u8,

    authorization_private_key_arn: Secret,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_secret_arn = "appSecretArn",
        .authorization_id = "authorizationId",
        .authorization_private_key_arn = "authorizationPrivateKeyArn",
    };
};
