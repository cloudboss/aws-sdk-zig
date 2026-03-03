const NestingLevelValue = @import("nesting_level_value.zig").NestingLevelValue;

/// Provides information that defines a DocumentDB endpoint.
pub const DocDbSettings = struct {
    /// The database name on the DocumentDB source endpoint.
    database_name: ?[]const u8 = null,

    /// Indicates the number of documents to preview to determine the document
    /// organization.
    /// Use this setting when `NestingLevel` is set to `"one"`.
    ///
    /// Must be a positive value greater than `0`. Default value is
    /// `1000`.
    docs_to_investigate: ?i32 = null,

    /// Specifies the document ID. Use this setting when `NestingLevel` is set to
    /// `"none"`.
    ///
    /// Default value is `"false"`.
    extract_doc_id: ?bool = null,

    /// The KMS key identifier that is used to encrypt the content on the
    /// replication
    /// instance. If you don't specify a value for the `KmsKeyId` parameter, then
    /// DMS
    /// uses your default encryption key. KMS creates the default encryption key for
    /// your
    /// Amazon Web Services account. Your Amazon Web Services account has a
    /// different default encryption key for each
    /// Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// Specifies either document or table mode.
    ///
    /// Default value is `"none"`. Specify `"none"` to use document mode.
    /// Specify `"one"` to use table mode.
    nesting_level: ?NestingLevelValue = null,

    /// The password for the user account you use to access the DocumentDB source
    /// endpoint.
    password: ?[]const u8 = null,

    /// The port value for the DocumentDB source endpoint.
    port: ?i32 = null,

    /// If `true`, DMS replicates data to shard collections. DMS only uses this
    /// setting if the target endpoint is a DocumentDB elastic cluster.
    ///
    /// When this setting is `true`, note the following:
    ///
    /// * You must set `TargetTablePrepMode` to `nothing`.
    ///
    /// * DMS automatically sets `useUpdateLookup` to
    /// `false`.
    replicate_shard_collections: ?bool = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the DocumentDB endpoint.
    ///
    /// You can specify one of two sets of values for these permissions. You can
    /// specify the
    /// values for this setting and `SecretsManagerSecretId`. Or you can specify
    /// clear-text values for `UserName`, `Password`,
    /// `ServerName`, and `Port`. You can't specify both. For more
    /// information on creating this `SecretsManagerSecret` and the
    /// `SecretsManagerAccessRoleArn` and `SecretsManagerSecretId`
    /// required to access it, see [Using secrets to access Database Migration
    /// Service
    /// resources](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#security-iam-secretsmanager) in the
    /// *Database Migration Service User Guide*.
    secrets_manager_access_role_arn: ?[]const u8 = null,

    /// The full ARN, partial ARN, or friendly name of the `SecretsManagerSecret`
    /// that contains the DocumentDB endpoint connection details.
    secrets_manager_secret_id: ?[]const u8 = null,

    /// The name of the server on the DocumentDB source endpoint.
    server_name: ?[]const u8 = null,

    /// The user name you use to access the DocumentDB source endpoint.
    username: ?[]const u8 = null,

    /// If `true`, DMS retrieves the entire document from the DocumentDB source
    /// during migration.
    /// This may cause a migration failure if the server response exceeds bandwidth
    /// limits. To fetch only updates
    /// and deletes during migration, set this parameter to `false`.
    use_update_look_up: ?bool = null,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .docs_to_investigate = "DocsToInvestigate",
        .extract_doc_id = "ExtractDocId",
        .kms_key_id = "KmsKeyId",
        .nesting_level = "NestingLevel",
        .password = "Password",
        .port = "Port",
        .replicate_shard_collections = "ReplicateShardCollections",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .username = "Username",
        .use_update_look_up = "UseUpdateLookUp",
    };
};
