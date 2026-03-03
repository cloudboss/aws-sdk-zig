/// An object representing the [OpenID Connect](https://openid.net/connect/)
/// (OIDC) identity provider information for the cluster.
pub const OIDC = struct {
    /// The issuer URL for the OIDC identity provider.
    issuer: ?[]const u8 = null,

    pub const json_field_names = .{
        .issuer = "issuer",
    };
};
