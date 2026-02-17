/// The established temporary security credentials of the session.
///
/// **Directory buckets** - These session credentials are only
/// supported for the authentication and authorization of Zonal endpoint API
/// operations on directory buckets.
pub const SessionCredentials = struct {
    /// A unique identifier that's associated with a secret access key. The access
    /// key ID and the secret
    /// access key are used together to sign programmatic Amazon Web Services
    /// requests cryptographically.
    access_key_id: []const u8,

    /// Temporary security credentials expire after a specified interval. After
    /// temporary credentials
    /// expire, any calls that you make with those credentials will fail. So you
    /// must generate a new set of
    /// temporary credentials. Temporary credentials cannot be extended or refreshed
    /// beyond the original
    /// specified interval.
    expiration: i64,

    /// A key that's used with the access key ID to cryptographically sign
    /// programmatic Amazon Web Services requests.
    /// Signing a request identifies the sender and prevents the request from being
    /// altered.
    secret_access_key: []const u8,

    /// A part of the temporary security credentials. The session token is used to
    /// validate the temporary
    /// security credentials.
    session_token: []const u8,
};
