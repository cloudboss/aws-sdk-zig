/// Describes the JWT options configured for the domain.
pub const JWTOptionsOutput = struct {
    /// True if JWT use is enabled.
    enabled: ?bool = null,

    /// The configured JWKS URL endpoint from which the cluster retrieves public
    /// keys to verify JWT requests.
    jwks_url: ?[]const u8 = null,

    /// The key used to verify the signature of incoming JWT requests.
    public_key: ?[]const u8 = null,

    /// The key used for matching the JWT roles attribute.
    roles_key: ?[]const u8 = null,

    /// The key used for matching the JWT subject attribute.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .jwks_url = "JwksUrl",
        .public_key = "PublicKey",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
