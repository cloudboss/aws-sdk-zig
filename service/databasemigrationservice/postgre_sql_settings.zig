const PostgreSQLAuthenticationMethod = @import("postgre_sql_authentication_method.zig").PostgreSQLAuthenticationMethod;
const DatabaseMode = @import("database_mode.zig").DatabaseMode;
const LongVarcharMappingType = @import("long_varchar_mapping_type.zig").LongVarcharMappingType;
const PluginNameValue = @import("plugin_name_value.zig").PluginNameValue;

/// Provides information that defines a PostgreSQL endpoint.
pub const PostgreSQLSettings = struct {
    /// For use with change data capture (CDC) only, this attribute has DMS bypass
    /// foreign
    /// keys and user triggers to reduce the time it takes to bulk load data.
    ///
    /// Example: `afterConnectScript=SET session_replication_role='replica'`
    after_connect_script: ?[]const u8,

    /// This attribute allows you to specify the authentication method as "iam
    /// auth".
    authentication_method: ?PostgreSQLAuthenticationMethod,

    /// The Babelfish for Aurora PostgreSQL database name for the endpoint.
    babelfish_database_name: ?[]const u8,

    /// To capture DDL events, DMS creates various artifacts in the PostgreSQL
    /// database when
    /// the task starts. You can later remove these artifacts.
    ///
    /// The default value is `true`.
    ///
    /// If this value is set to `N`, you don't have to create tables or triggers on
    /// the source database.
    capture_ddls: ?bool,

    /// Specifies the default behavior of the replication's handling of PostgreSQL-
    /// compatible
    /// endpoints that require some additional configuration, such as Babelfish
    /// endpoints.
    database_mode: ?DatabaseMode,

    /// Database name for the endpoint.
    database_name: ?[]const u8,

    /// The schema in which the operational DDL database artifacts are created.
    ///
    /// The default value is `public`.
    ///
    /// Example: `ddlArtifactsSchema=xyzddlschema;`
    ddl_artifacts_schema: ?[]const u8,

    /// Disables the Unicode source filter with PostgreSQL, for values passed into
    /// the Selection
    /// rule filter on Source Endpoint column values. By default DMS performs source
    /// filter
    /// comparisons using a Unicode string which can cause look ups to ignore the
    /// indexes in the
    /// text columns and slow down migrations.
    ///
    /// Unicode support should only be disabled when using a selection rule filter
    /// is on a text
    /// column in the Source database that is indexed.
    disable_unicode_source_filter: ?bool,

    /// Sets the client statement timeout for the PostgreSQL instance, in seconds.
    /// The default
    /// value is 60 seconds.
    ///
    /// Example: `executeTimeout=100;`
    execute_timeout: ?i32,

    /// When set to `true`, this value causes a task to fail if the actual size of a
    /// LOB column is greater than the specified `LobMaxSize`.
    ///
    /// The default value is `false`.
    ///
    /// If task is set to Limited LOB mode and this option is set to true, the task
    /// fails
    /// instead of truncating the LOB data.
    fail_tasks_on_lob_truncation: ?bool,

    /// The write-ahead log (WAL) heartbeat feature mimics a dummy transaction. By
    /// doing this,
    /// it prevents idle logical replication slots from holding onto old WAL logs,
    /// which can result
    /// in storage full situations on the source. This heartbeat keeps `restart_lsn`
    /// moving and prevents storage full scenarios.
    ///
    /// The default value is `false`.
    heartbeat_enable: ?bool,

    /// Sets the WAL heartbeat frequency (in minutes).
    ///
    /// The default value is 5 minutes.
    heartbeat_frequency: ?i32,

    /// Sets the schema in which the heartbeat artifacts are created.
    ///
    /// The default value is `public`.
    heartbeat_schema: ?[]const u8,

    /// When true, lets PostgreSQL migrate the boolean type as boolean. By default,
    /// PostgreSQL
    /// migrates booleans as `varchar(5)`. You must set this setting on both the
    /// source
    /// and target endpoints for it to take effect.
    ///
    /// The default value is `false`.
    map_boolean_as_boolean: ?bool,

    /// When true, DMS migrates JSONB values as CLOB.
    ///
    /// The default value is `false`.
    map_jsonb_as_clob: ?bool,

    /// Sets what datatype to map LONG values as.
    ///
    /// The default value is `wstring`.
    map_long_varchar_as: ?LongVarcharMappingType,

    /// Specifies the maximum size (in KB) of any .csv file used to transfer data to
    /// PostgreSQL.
    ///
    /// The default value is 32,768 KB (32 MB).
    ///
    /// Example: `maxFileSize=512`
    max_file_size: ?i32,

    /// Endpoint connection password.
    password: ?[]const u8,

    /// Specifies the plugin to use to create a replication slot.
    ///
    /// The default value is `pglogical`.
    plugin_name: ?PluginNameValue,

    /// Endpoint TCP port. The default is 5432.
    port: ?i32,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the PostgreSQL endpoint.
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
    /// that contains the PostgreSQL endpoint connection details.
    secrets_manager_secret_id: ?[]const u8,

    /// The host name of the endpoint database.
    ///
    /// For an Amazon RDS PostgreSQL instance, this is the output of
    /// [DescribeDBInstances](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBInstances.html), in the `
    /// [Endpoint](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_Endpoint.html).Address` field.
    ///
    /// For an Aurora PostgreSQL instance, this is the output of
    /// [DescribeDBClusters](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBClusters.html), in the `Endpoint` field.
    server_name: ?[]const u8,

    /// The IAM role arn you can use to authenticate the connection to your
    /// endpoint. Ensure to include `iam:PassRole` and `rds-db:connect` actions in
    /// permission policy.
    service_access_role_arn: ?[]const u8,

    /// Sets the name of a previously created logical replication slot for a change
    /// data capture
    /// (CDC) load of the PostgreSQL source instance.
    ///
    /// When used with the `CdcStartPosition` request parameter for the DMS API ,
    /// this attribute also makes it possible to use native CDC start points. DMS
    /// verifies that the
    /// specified logical replication slot exists before starting the CDC load task.
    /// It also
    /// verifies that the task was created with a valid setting of
    /// `CdcStartPosition`.
    /// If the specified slot doesn't exist or the task doesn't have a valid
    /// `CdcStartPosition` setting, DMS raises an error.
    ///
    /// For more information about setting the `CdcStartPosition` request parameter,
    /// see [Determining a CDC native start
    /// point](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Task.CDC.html#CHAP_Task.CDC.StartPoint.Native) in the *Database Migration Service User
    /// Guide*. For more information about using `CdcStartPosition`, see
    /// [CreateReplicationTask](https://docs.aws.amazon.com/dms/latest/APIReference/API_CreateReplicationTask.html), [StartReplicationTask](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html), and [ModifyReplicationTask](https://docs.aws.amazon.com/dms/latest/APIReference/API_ModifyReplicationTask.html).
    slot_name: ?[]const u8,

    /// Use the `TrimSpaceInChar` source endpoint setting to trim data on CHAR and
    /// NCHAR data types during migration. The default value is `true`.
    trim_space_in_char: ?bool,

    /// Endpoint connection user name.
    username: ?[]const u8,

    pub const json_field_names = .{
        .after_connect_script = "AfterConnectScript",
        .authentication_method = "AuthenticationMethod",
        .babelfish_database_name = "BabelfishDatabaseName",
        .capture_ddls = "CaptureDdls",
        .database_mode = "DatabaseMode",
        .database_name = "DatabaseName",
        .ddl_artifacts_schema = "DdlArtifactsSchema",
        .disable_unicode_source_filter = "DisableUnicodeSourceFilter",
        .execute_timeout = "ExecuteTimeout",
        .fail_tasks_on_lob_truncation = "FailTasksOnLobTruncation",
        .heartbeat_enable = "HeartbeatEnable",
        .heartbeat_frequency = "HeartbeatFrequency",
        .heartbeat_schema = "HeartbeatSchema",
        .map_boolean_as_boolean = "MapBooleanAsBoolean",
        .map_jsonb_as_clob = "MapJsonbAsClob",
        .map_long_varchar_as = "MapLongVarcharAs",
        .max_file_size = "MaxFileSize",
        .password = "Password",
        .plugin_name = "PluginName",
        .port = "Port",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .slot_name = "SlotName",
        .trim_space_in_char = "TrimSpaceInChar",
        .username = "Username",
    };
};
