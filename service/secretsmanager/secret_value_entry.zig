/// A structure that contains the secret value and other details for a secret.
pub const SecretValueEntry = struct {
    /// The Amazon Resource Name (ARN) of the secret.
    arn: ?[]const u8 = null,

    /// The date the secret was created.
    created_date: ?i64 = null,

    /// The friendly name of the secret.
    name: ?[]const u8 = null,

    /// The decrypted secret value, if the secret value was originally provided as
    /// binary data
    /// in the form of a byte array. The parameter represents the binary data as a
    /// [base64-encoded](https://tools.ietf.org/html/rfc4648#section-4)
    /// string.
    secret_binary: ?[]const u8 = null,

    /// The decrypted secret value, if the secret value was originally provided as a
    /// string or
    /// through the Secrets Manager console.
    secret_string: ?[]const u8 = null,

    /// The unique version identifier of this version of the secret.
    version_id: ?[]const u8 = null,

    /// A list of all of the staging labels currently attached to this version of
    /// the
    /// secret.
    version_stages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .created_date = "CreatedDate",
        .name = "Name",
        .secret_binary = "SecretBinary",
        .secret_string = "SecretString",
        .version_id = "VersionId",
        .version_stages = "VersionStages",
    };
};
