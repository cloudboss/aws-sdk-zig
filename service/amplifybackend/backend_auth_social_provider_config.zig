/// Describes third-party social federation configurations for allowing your app
/// users to sign in using OAuth.
pub const BackendAuthSocialProviderConfig = struct {
    /// Describes the client_id, which can be obtained from the third-party social
    /// federation provider.
    client_id: ?[]const u8 = null,

    /// Describes the client_secret, which can be obtained from third-party social
    /// federation providers.
    client_secret: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
    };
};
