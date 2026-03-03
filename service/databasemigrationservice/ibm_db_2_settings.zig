/// Provides information that defines an IBM Db2 LUW endpoint.
pub const IBMDb2Settings = struct {
    /// For ongoing replication (CDC), use CurrentLSN to specify a log sequence
    /// number (LSN)
    /// where you want the replication to start.
    current_lsn: ?[]const u8 = null,

    /// Database name for the endpoint.
    database_name: ?[]const u8 = null,

    /// If true, DMS saves any .csv files to the Db2 LUW target that were used to
    /// replicate
    /// data. DMS uses these files for analysis and troubleshooting.
    ///
    /// The default value is false.
    keep_csv_files: ?bool = null,

    /// The amount of time (in milliseconds) before DMS times out operations
    /// performed by DMS
    /// on the Db2 target. The default value is 1200 (20 minutes).
    load_timeout: ?i32 = null,

    /// Specifies the maximum size (in KB) of .csv files used to transfer data to
    /// Db2
    /// LUW.
    max_file_size: ?i32 = null,

    /// Maximum number of bytes per read, as a NUMBER value. The default is 64 KB.
    max_k_bytes_per_read: ?i32 = null,

    /// Endpoint connection password.
    password: ?[]const u8 = null,

    /// Endpoint TCP port. The default value is 50000.
    port: ?i32 = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the Db2 LUW endpoint.
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
    /// that contains the Db2 LUW endpoint connection details.
    secrets_manager_secret_id: ?[]const u8 = null,

    /// Fully qualified domain name of the endpoint.
    server_name: ?[]const u8 = null,

    /// Enables ongoing replication (CDC) as a BOOLEAN value. The default is true.
    set_data_capture_changes: ?bool = null,

    /// Endpoint connection user name.
    username: ?[]const u8 = null,

    /// The size (in KB) of the in-memory file write buffer used when generating
    /// .csv files on
    /// the local disk on the DMS replication instance. The default value is 1024 (1
    /// MB).
    write_buffer_size: ?i32 = null,

    pub const json_field_names = .{
        .current_lsn = "CurrentLsn",
        .database_name = "DatabaseName",
        .keep_csv_files = "KeepCsvFiles",
        .load_timeout = "LoadTimeout",
        .max_file_size = "MaxFileSize",
        .max_k_bytes_per_read = "MaxKBytesPerRead",
        .password = "Password",
        .port = "Port",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .set_data_capture_changes = "SetDataCaptureChanges",
        .username = "Username",
        .write_buffer_size = "WriteBufferSize",
    };
};
