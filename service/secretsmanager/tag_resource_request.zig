const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The identifier for the secret to attach tags to. You can specify either the
    /// Amazon
    /// Resource Name (ARN) or the friendly name of the secret.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// The tags to attach to the secret as a JSON text string argument. Each
    /// element in the
    /// list consists of a `Key` and a `Value`.
    ///
    /// For storing multiple values, we recommend that you use a JSON text
    /// string argument and specify key/value pairs. For more information, see
    /// [Specifying parameter values for the Amazon Web Services
    /// CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters.html)
    /// in the Amazon Web Services CLI User Guide.
    tags: []const Tag,

    pub const json_field_names = .{
        .secret_id = "SecretId",
        .tags = "Tags",
    };
};
