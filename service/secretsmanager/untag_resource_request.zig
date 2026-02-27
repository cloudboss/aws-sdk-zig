pub const UntagResourceRequest = struct {
    /// The ARN or name of the secret.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// A list of tag key names to remove from the secret. You don't specify the
    /// value. Both
    /// the key and its associated value are removed.
    ///
    /// This parameter requires a JSON text string argument.
    ///
    /// For storing multiple values, we recommend that you use a JSON text
    /// string argument and specify key/value pairs. For more information, see
    /// [Specifying parameter values for the Amazon Web Services
    /// CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters.html)
    /// in the Amazon Web Services CLI User Guide.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .secret_id = "SecretId",
        .tag_keys = "TagKeys",
    };
};
