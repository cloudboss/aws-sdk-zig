/// Contains information about a client secret, including its unique identifier,
/// value, and creation timestamp.
pub const ClientSecretDescriptorType = struct {
    /// The date and time when the client secret was created.
    client_secret_create_date: ?i64 = null,

    /// The unique identifier for the client secret. This identifier follows the
    /// format --.
    client_secret_id: ?[]const u8 = null,

    /// The actual secret value. This is only returned when creating a new secret
    /// and only if Amazon Cognito generated the secret. For custom secrets that you
    /// provide, this field is not included in the response.
    client_secret_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_secret_create_date = "ClientSecretCreateDate",
        .client_secret_id = "ClientSecretId",
        .client_secret_value = "ClientSecretValue",
    };
};
