/// The connector-specific profile credentials required by Infor Nexus.
pub const InforNexusConnectorProfileCredentials = struct {
    /// The Access Key portion of the credentials.
    access_key_id: []const u8,

    /// The encryption keys used to encrypt data.
    datakey: []const u8,

    /// The secret key used to sign requests.
    secret_access_key: []const u8,

    /// The identifier for the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .datakey = "datakey",
        .secret_access_key = "secretAccessKey",
        .user_id = "userId",
    };
};
