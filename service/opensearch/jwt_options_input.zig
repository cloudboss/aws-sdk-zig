/// The JWT authentication and authorization configuration for an Amazon
/// OpenSearch
/// Service domain.
pub const JWTOptionsInput = struct {
    /// True to enable JWT authentication and authorization for a domain.
    enabled: ?bool = null,

    /// The URL endpoint that hosts the JSON Web Key Set (JWKS) containing public
    /// keys used to verify JWT signatures.
    jwks_url: ?[]const u8 = null,

    /// Element of the JWT assertion used by the cluster to verify JWT signatures.
    public_key: ?[]const u8 = null,

    /// Element of the JWT assertion to use for roles.
    roles_key: ?[]const u8 = null,

    /// Element of the JWT assertion to use for the user name.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .jwks_url = "JwksUrl",
        .public_key = "PublicKey",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
