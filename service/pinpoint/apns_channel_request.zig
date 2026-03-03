/// Specifies the status and settings of the APNs (Apple Push Notification
/// service) channel for an application.
pub const APNSChannelRequest = struct {
    /// The bundle identifier that's assigned to your iOS app. This identifier is
    /// used for APNs tokens.
    bundle_id: ?[]const u8 = null,

    /// The APNs client certificate that you received from Apple, if you want Amazon
    /// Pinpoint to communicate with APNs by using an APNs certificate.
    certificate: ?[]const u8 = null,

    /// The default authentication method that you want Amazon Pinpoint to use when
    /// authenticating with APNs, key or certificate.
    default_authentication_method: ?[]const u8 = null,

    /// Specifies whether to enable the APNs channel for the application.
    enabled: ?bool = null,

    /// The private key for the APNs client certificate that you want Amazon
    /// Pinpoint to use to communicate with APNs.
    private_key: ?[]const u8 = null,

    /// The identifier that's assigned to your Apple developer account team. This
    /// identifier is used for APNs tokens.
    team_id: ?[]const u8 = null,

    /// The authentication key to use for APNs tokens.
    token_key: ?[]const u8 = null,

    /// The key identifier that's assigned to your APNs signing key, if you want
    /// Amazon Pinpoint to communicate with APNs by using APNs tokens.
    token_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
        .certificate = "Certificate",
        .default_authentication_method = "DefaultAuthenticationMethod",
        .enabled = "Enabled",
        .private_key = "PrivateKey",
        .team_id = "TeamId",
        .token_key = "TokenKey",
        .token_key_id = "TokenKeyId",
    };
};
