const OIDC = @import("oidc.zig").OIDC;

/// An object representing an identity provider.
pub const Identity = struct {
    /// An object representing the [OpenID Connect](https://openid.net/connect/)
    /// identity provider information.
    oidc: ?OIDC = null,

    pub const json_field_names = .{
        .oidc = "oidc",
    };
};
