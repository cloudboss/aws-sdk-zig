/// Contains a credentials secret that's stored in Secrets Manager.
pub const SecretsManagerCredentialsProvider = struct {
    /// The ID of the Secrets Manager secret that contains credentials.
    secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_id = "SecretId",
    };
};
