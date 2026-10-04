/// Contains a reference to a secret stored in Amazon Web Services Secrets
/// Manager.
pub const SecretReference = struct {
    /// The JSON key used to extract the secret value from the Amazon Web Services
    /// Secrets Manager secret.
    json_key: []const u8,

    /// The ID of the Amazon Web Services Secrets Manager secret that stores the
    /// secret value.
    secret_id: []const u8,

    pub const json_field_names = .{
        .json_key = "jsonKey",
        .secret_id = "secretId",
    };
};
