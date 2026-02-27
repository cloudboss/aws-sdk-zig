const LogExport = @import("log_export.zig").LogExport;
const NamespaceStatus = @import("namespace_status.zig").NamespaceStatus;

/// A collection of database objects and users.
pub const Namespace = struct {
    /// The Amazon Resource Name (ARN) for the namespace's admin user credentials
    /// secret.
    admin_password_secret_arn: ?[]const u8,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// namespace's admin credentials secret.
    admin_password_secret_kms_key_id: ?[]const u8,

    /// The username of the administrator for the first database created in the
    /// namespace.
    admin_username: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Glue Data Catalog associated with the
    /// namespace enabled with Amazon Redshift federated permissions.
    catalog_arn: ?[]const u8,

    /// The date of when the namespace was created.
    creation_date: ?i64,

    /// The name of the first database created in the namespace.
    db_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role to set as a default in the
    /// namespace.
    default_iam_role_arn: ?[]const u8,

    /// A list of IAM roles to associate with the namespace.
    iam_roles: ?[]const []const u8,

    /// The ID of the Amazon Web Services Key Management Service key used to encrypt
    /// your data.
    kms_key_id: ?[]const u8,

    /// The status of the lakehouse registration for the namespace. Indicates
    /// whether the namespace is successfully registered with Amazon Redshift
    /// federated permissions.
    lakehouse_registration_status: ?[]const u8,

    /// The types of logs the namespace can export. Available export types are User
    /// log, Connection log, and User activity log.
    log_exports: ?[]const LogExport,

    /// The Amazon Resource Name (ARN) associated with a namespace.
    namespace_arn: ?[]const u8,

    /// The unique identifier of a namespace.
    namespace_id: ?[]const u8,

    /// The name of the namespace. Must be between 3-64 alphanumeric characters in
    /// lowercase, and it cannot be a reserved word. A list of reserved words can be
    /// found in [Reserved
    /// Words](https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in
    /// the Amazon Redshift Database Developer Guide.
    namespace_name: ?[]const u8,

    /// The status of the namespace.
    status: ?NamespaceStatus,

    pub const json_field_names = .{
        .admin_password_secret_arn = "adminPasswordSecretArn",
        .admin_password_secret_kms_key_id = "adminPasswordSecretKmsKeyId",
        .admin_username = "adminUsername",
        .catalog_arn = "catalogArn",
        .creation_date = "creationDate",
        .db_name = "dbName",
        .default_iam_role_arn = "defaultIamRoleArn",
        .iam_roles = "iamRoles",
        .kms_key_id = "kmsKeyId",
        .lakehouse_registration_status = "lakehouseRegistrationStatus",
        .log_exports = "logExports",
        .namespace_arn = "namespaceArn",
        .namespace_id = "namespaceId",
        .namespace_name = "namespaceName",
        .status = "status",
    };
};
