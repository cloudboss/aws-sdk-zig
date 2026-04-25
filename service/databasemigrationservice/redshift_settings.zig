const EncryptionModeValue = @import("encryption_mode_value.zig").EncryptionModeValue;

/// Provides information that defines an Amazon Redshift endpoint.
pub const RedshiftSettings = struct {
    /// A value that indicates to allow any date format, including invalid formats
    /// such as
    /// 00/00/00 00:00:00, to be loaded without generating an error. You can choose
    /// `true` or `false` (the default).
    ///
    /// This parameter applies only to TIMESTAMP and DATE columns. Always use
    /// ACCEPTANYDATE with
    /// the DATEFORMAT parameter. If the date format for the data doesn't match the
    /// DATEFORMAT
    /// specification, Amazon Redshift inserts a NULL value into that field.
    accept_any_date: ?bool = null,

    /// Code to run after connecting. This parameter should contain the code itself,
    /// not the
    /// name of a file containing the code.
    after_connect_script: ?[]const u8 = null,

    /// An S3 folder where the comma-separated-value (.csv) files are stored before
    /// being
    /// uploaded to the target Redshift cluster.
    ///
    /// For full load mode, DMS converts source records into .csv files and loads
    /// them to the
    /// *BucketFolder/TableID* path. DMS uses the Redshift
    /// `COPY` command to upload the .csv files to the target table. The files are
    /// deleted once the `COPY` operation has finished. For more information, see
    /// [COPY](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html) in the
    /// *Amazon Redshift Database Developer Guide*.
    ///
    /// For change-data-capture (CDC) mode, DMS creates a *NetChanges*
    /// table, and loads the .csv files to this *BucketFolder/NetChangesTableID*
    /// path.
    bucket_folder: ?[]const u8 = null,

    /// The name of the intermediate S3 bucket used to store .csv files before
    /// uploading data to
    /// Redshift.
    bucket_name: ?[]const u8 = null,

    /// If Amazon Redshift is configured to support case sensitive schema names, set
    /// `CaseSensitiveNames` to `true`. The default is
    /// `false`.
    case_sensitive_names: ?bool = null,

    /// If you set `CompUpdate` to `true` Amazon Redshift applies
    /// automatic compression if the table is empty. This applies even if the table
    /// columns already
    /// have encodings other than `RAW`. If you set `CompUpdate` to
    /// `false`, automatic compression is disabled and existing column encodings
    /// aren't changed. The default is `true`.
    comp_update: ?bool = null,

    /// A value that sets the amount of time to wait (in milliseconds) before timing
    /// out,
    /// beginning from when you initially establish a connection.
    connection_timeout: ?i32 = null,

    /// The name of the Amazon Redshift data warehouse (service) that you are
    /// working
    /// with.
    database_name: ?[]const u8 = null,

    /// The date format that you are using. Valid values are `auto`
    /// (case-sensitive),
    /// your date format string enclosed in quotes, or NULL. If this parameter is
    /// left unset
    /// (NULL), it defaults to a format of 'YYYY-MM-DD'. Using `auto` recognizes
    /// most
    /// strings, even some that aren't supported when you use a date format string.
    ///
    /// If your date and time values use formats different from each other, set this
    /// to
    /// `auto`.
    date_format: ?[]const u8 = null,

    /// A value that specifies whether DMS should migrate empty CHAR and VARCHAR
    /// fields as
    /// NULL. A value of `true` sets empty CHAR and VARCHAR fields to null. The
    /// default
    /// is `false`.
    empty_as_null: ?bool = null,

    /// The type of server-side encryption that you want to use for your data. This
    /// encryption
    /// type is part of the endpoint settings or the extra connections attributes
    /// for Amazon S3.
    /// You can choose either `SSE_S3` (the default) or `SSE_KMS`.
    ///
    /// For the `ModifyEndpoint` operation, you can change the existing value of
    /// the `EncryptionMode` parameter from `SSE_KMS` to
    /// `SSE_S3`. But you can’t change the existing value from `SSE_S3`
    /// to `SSE_KMS`.
    ///
    /// To use `SSE_S3`, create an Identity and Access Management (IAM) role with a
    /// policy that allows
    /// `"arn:aws:s3:::*"` to use the following actions: `"s3:PutObject",
    /// "s3:ListBucket"`
    encryption_mode: ?EncryptionModeValue = null,

    /// This setting is only valid for a full-load migration task. Set `ExplicitIds`
    /// to `true` to have tables with `IDENTITY` columns override their
    /// auto-generated values with explicit values loaded from the source data files
    /// used to
    /// populate the tables. The default is `false`.
    explicit_ids: ?bool = null,

    /// The number of threads used to upload a single file. This parameter accepts a
    /// value from
    /// 1 through 64. It defaults to 10.
    ///
    /// The number of parallel streams used to upload a single .csv file to an S3
    /// bucket using
    /// S3 Multipart Upload. For more information, see [Multipart upload
    /// overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html).
    ///
    /// `FileTransferUploadStreams` accepts a value from 1 through 64. It defaults
    /// to
    /// 10.
    file_transfer_upload_streams: ?i32 = null,

    /// The amount of time to wait (in seconds) before timing out of operations
    /// performed
    /// by DMS on a Redshift cluster, such as Redshift COPY, INSERT, DELETE, and
    /// UPDATE.
    load_timeout: ?i32 = null,

    /// When true, lets Redshift migrate the boolean type as boolean. By default,
    /// Redshift
    /// migrates booleans as `varchar(1)`. You must set this setting on both the
    /// source
    /// and target endpoints for it to take effect.
    map_boolean_as_boolean: ?bool = null,

    /// The maximum size (in KB) of any .csv file used to load data on an S3 bucket
    /// and transfer
    /// data to Amazon Redshift. It defaults to 1048576KB (1 GB).
    max_file_size: ?i32 = null,

    /// The password for the user named in the `username` property.
    password: ?[]const u8 = null,

    /// The port number for Amazon Redshift. The default value is 5439.
    port: ?i32 = null,

    /// A value that specifies to remove surrounding quotation marks from strings in
    /// the
    /// incoming data. All characters within the quotation marks, including
    /// delimiters, are
    /// retained. Choose `true` to remove quotation marks. The default is
    /// `false`.
    remove_quotes: ?bool = null,

    /// A value that specifies to replaces the invalid characters specified in
    /// `ReplaceInvalidChars`, substituting the specified characters instead. The
    /// default is `"?"`.
    replace_chars: ?[]const u8 = null,

    /// A list of characters that you want to replace. Use with
    /// `ReplaceChars`.
    replace_invalid_chars: ?[]const u8 = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the Amazon Redshift endpoint.
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
    /// that contains the Amazon Redshift endpoint connection details.
    secrets_manager_secret_id: ?[]const u8 = null,

    /// The name of the Amazon Redshift cluster you are using.
    server_name: ?[]const u8 = null,

    /// The KMS key ID. If you are using `SSE_KMS` for the
    /// `EncryptionMode`, provide this key ID. The key that you use needs an
    /// attached
    /// policy that enables IAM user permissions and allows use of the key.
    server_side_encryption_kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that has access to the Amazon
    /// Redshift
    /// service. The role must allow the `iam:PassRole` action.
    service_access_role_arn: ?[]const u8 = null,

    /// The time format that you want to use. Valid values are `auto`
    /// (case-sensitive), `'timeformat_string'`, `'epochsecs'`, or
    /// `'epochmillisecs'`. It defaults to 10. Using `auto` recognizes
    /// most strings, even some that aren't supported when you use a time format
    /// string.
    ///
    /// If your date and time values use formats different from each other, set this
    /// parameter
    /// to `auto`.
    time_format: ?[]const u8 = null,

    /// A value that specifies to remove the trailing white space characters from a
    /// VARCHAR
    /// string. This parameter applies only to columns with a VARCHAR data type.
    /// Choose
    /// `true` to remove unneeded white space. The default is
    /// `false`.
    trim_blanks: ?bool = null,

    /// A value that specifies to truncate data in columns to the appropriate number
    /// of
    /// characters, so that the data fits in the column. This parameter applies only
    /// to columns
    /// with a VARCHAR or CHAR data type, and rows with a size of 4 MB or less.
    /// Choose
    /// `true` to truncate data. The default is `false`.
    truncate_columns: ?bool = null,

    /// An Amazon Redshift user name for a registered user.
    username: ?[]const u8 = null,

    /// The size (in KB) of the in-memory file write buffer used when generating
    /// .csv files on
    /// the local disk at the DMS replication instance. The default value is 1000
    /// (buffer size is
    /// 1000KB).
    write_buffer_size: ?i32 = null,

    pub const json_field_names = .{
        .accept_any_date = "AcceptAnyDate",
        .after_connect_script = "AfterConnectScript",
        .bucket_folder = "BucketFolder",
        .bucket_name = "BucketName",
        .case_sensitive_names = "CaseSensitiveNames",
        .comp_update = "CompUpdate",
        .connection_timeout = "ConnectionTimeout",
        .database_name = "DatabaseName",
        .date_format = "DateFormat",
        .empty_as_null = "EmptyAsNull",
        .encryption_mode = "EncryptionMode",
        .explicit_ids = "ExplicitIds",
        .file_transfer_upload_streams = "FileTransferUploadStreams",
        .load_timeout = "LoadTimeout",
        .map_boolean_as_boolean = "MapBooleanAsBoolean",
        .max_file_size = "MaxFileSize",
        .password = "Password",
        .port = "Port",
        .remove_quotes = "RemoveQuotes",
        .replace_chars = "ReplaceChars",
        .replace_invalid_chars = "ReplaceInvalidChars",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .server_side_encryption_kms_key_id = "ServerSideEncryptionKmsKeyId",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .time_format = "TimeFormat",
        .trim_blanks = "TrimBlanks",
        .truncate_columns = "TruncateColumns",
        .username = "Username",
        .write_buffer_size = "WriteBufferSize",
    };
};
