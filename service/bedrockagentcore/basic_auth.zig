/// Configuration for HTTP Basic Authentication using credentials stored in
/// Amazon Web Services Secrets Manager. The secret must contain a JSON object
/// with `username` and `password` string fields. Username allows alphanumeric
/// characters and `@._+=-` symbols (pattern: `^[a-zA-Z0-9@._+=\-]+$`). Password
/// allows alphanumeric characters and `@._+=-!#$%&*` symbols (pattern:
/// `^[a-zA-Z0-9@._+=\-!#$%&*]+$`). Both fields have a maximum length of 256
/// characters.
pub const BasicAuth = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret containing proxy credentials. The secret must be a JSON object with
    /// `username` and `password` string fields that meet validation requirements.
    /// The caller must have `secretsmanager:GetSecretValue` permission for this
    /// ARN. Example secret format: `{"username": "proxy_user", "password":
    /// "secure_password"}`
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
    };
};
