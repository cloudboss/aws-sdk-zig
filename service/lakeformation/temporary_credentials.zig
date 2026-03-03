/// A temporary set of credentials for an Lake Formation user. These credentials
/// are scoped down to only access the raw data sources that the user has access
/// to.
///
/// The temporary security credentials consist of an access key and a session
/// token. The access key consists of an access key ID and a secret key. When
/// the credentials are created, they are associated with an IAM access control
/// policy that limits what the user can do when using the credentials.
pub const TemporaryCredentials = struct {
    /// The access key ID for the temporary credentials.
    access_key_id: ?[]const u8 = null,

    /// The date and time when the temporary credentials expire.
    expiration: ?i64 = null,

    /// The secret key for the temporary credentials.
    secret_access_key: ?[]const u8 = null,

    /// The session token for the temporary credentials.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .expiration = "Expiration",
        .secret_access_key = "SecretAccessKey",
        .session_token = "SessionToken",
    };
};
