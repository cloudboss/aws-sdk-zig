/// The Amazon Web Services Security Token Service temporary credential that S3
/// Access Grants vends to grantees and client applications.
pub const Credentials = struct {
    /// The unique access key ID of the Amazon Web Services STS temporary credential
    /// that S3 Access Grants vends to grantees and client applications.
    access_key_id: ?[]const u8 = null,

    /// The expiration date and time of the temporary credential that S3 Access
    /// Grants vends to grantees and client applications.
    expiration: ?i64 = null,

    /// The secret access key of the Amazon Web Services STS temporary credential
    /// that S3 Access Grants vends to grantees and client applications.
    secret_access_key: ?[]const u8 = null,

    /// The Amazon Web Services STS temporary credential that S3 Access Grants vends
    /// to grantees and client applications.
    session_token: ?[]const u8 = null,
};
