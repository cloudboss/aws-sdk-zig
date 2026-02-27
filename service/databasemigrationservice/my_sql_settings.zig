const MySQLAuthenticationMethod = @import("my_sql_authentication_method.zig").MySQLAuthenticationMethod;
const TargetDbType = @import("target_db_type.zig").TargetDbType;

/// Provides information that defines a MySQL endpoint.
pub const MySQLSettings = struct {
    /// Specifies a script to run immediately after DMS connects to the endpoint.
    /// The
    /// migration task continues running regardless if the SQL statement succeeds or
    /// fails.
    ///
    /// For this parameter, provide the code of the script itself, not the name of a
    /// file
    /// containing the script.
    after_connect_script: ?[]const u8,

    /// This attribute allows you to specify the authentication method as "iam
    /// auth".
    authentication_method: ?MySQLAuthenticationMethod,

    /// Cleans and recreates table metadata information on the replication instance
    /// when a
    /// mismatch occurs. For example, in a situation where running an alter DDL on
    /// the table could
    /// result in different information about the table cached in the replication
    /// instance.
    clean_source_metadata_on_mismatch: ?bool,

    /// Database name for the endpoint. For a MySQL source or target endpoint, don't
    /// explicitly
    /// specify the database using the `DatabaseName` request parameter on either
    /// the
    /// `CreateEndpoint` or `ModifyEndpoint` API call. Specifying
    /// `DatabaseName` when you create or modify a MySQL endpoint replicates all the
    /// task tables to this single database. For MySQL endpoints, you specify the
    /// database only
    /// when you specify the schema in the table-mapping rules of the DMS task.
    database_name: ?[]const u8,

    /// Specifies how often to check the binary log for new changes/events when the
    /// database is
    /// idle. The default is five seconds.
    ///
    /// Example: `eventsPollInterval=5;`
    ///
    /// In the example, DMS checks for changes in the binary logs every five
    /// seconds.
    events_poll_interval: ?i32,

    /// Sets the client statement timeout (in seconds) for a MySQL source endpoint.
    execute_timeout: ?i32,

    /// Specifies the maximum size (in KB) of any .csv file used to transfer data to
    /// a
    /// MySQL-compatible database.
    ///
    /// Example: `maxFileSize=512`
    max_file_size: ?i32,

    /// Improves performance when loading data into the MySQL-compatible target
    /// database.
    /// Specifies how many threads to use to load the data into the MySQL-compatible
    /// target
    /// database. Setting a large number of threads can have an adverse effect on
    /// database
    /// performance, because a separate connection is required for each thread. The
    /// default is
    /// one.
    ///
    /// Example: `parallelLoadThreads=1`
    parallel_load_threads: ?i32,

    /// Endpoint connection password.
    password: ?[]const u8,

    /// Endpoint TCP port.
    port: ?i32,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the MySQL endpoint.
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
    secrets_manager_access_role_arn: ?[]const u8,

    /// The full ARN, partial ARN, or friendly name of the `SecretsManagerSecret`
    /// that contains the MySQL endpoint connection details.
    secrets_manager_secret_id: ?[]const u8,

    /// The host name of the endpoint database.
    ///
    /// For an Amazon RDS MySQL instance, this is the output of
    /// [DescribeDBInstances](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBInstances.html), in the `
    /// [Endpoint](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_Endpoint.html).Address` field.
    ///
    /// For an Aurora MySQL instance, this is the output of
    /// [DescribeDBClusters](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBClusters.html), in the `Endpoint` field.
    server_name: ?[]const u8,

    /// Specifies the time zone for the source MySQL database.
    ///
    /// Example: `serverTimezone=US/Pacific;`
    ///
    /// Note: Do not enclose time zones in single quotes.
    server_timezone: ?[]const u8,

    /// The IAM role you can use to authenticate when connecting to your endpoint.
    /// Ensure to include `iam:PassRole` and `rds-db:connect` actions in permission
    /// policy.
    service_access_role_arn: ?[]const u8,

    /// Specifies where to migrate source tables on the target, either to a single
    /// database or
    /// multiple databases. If you specify `SPECIFIC_DATABASE`, specify the database
    /// name using the `DatabaseName` parameter of the `Endpoint`
    /// object.
    ///
    /// Example: `targetDbType=MULTIPLE_DATABASES`
    target_db_type: ?TargetDbType,

    /// Endpoint connection user name.
    username: ?[]const u8,

    pub const json_field_names = .{
        .after_connect_script = "AfterConnectScript",
        .authentication_method = "AuthenticationMethod",
        .clean_source_metadata_on_mismatch = "CleanSourceMetadataOnMismatch",
        .database_name = "DatabaseName",
        .events_poll_interval = "EventsPollInterval",
        .execute_timeout = "ExecuteTimeout",
        .max_file_size = "MaxFileSize",
        .parallel_load_threads = "ParallelLoadThreads",
        .password = "Password",
        .port = "Port",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .server_timezone = "ServerTimezone",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .target_db_type = "TargetDbType",
        .username = "Username",
    };
};
