const SqlServerAuthenticationMethod = @import("sql_server_authentication_method.zig").SqlServerAuthenticationMethod;
const SafeguardPolicy = @import("safeguard_policy.zig").SafeguardPolicy;
const TlogAccessMode = @import("tlog_access_mode.zig").TlogAccessMode;

/// Provides information that defines a Microsoft SQL Server endpoint.
pub const MicrosoftSQLServerSettings = struct {
    /// Specifies the authentication method to be used with Microsoft SQL Server.
    authentication_method: ?SqlServerAuthenticationMethod = null,

    /// The maximum size of the packets (in bytes) used to transfer data using BCP.
    bcp_packet_size: ?i32 = null,

    /// Specifies a file group for the DMS internal tables. When the replication
    /// task starts,
    /// all the internal DMS control tables (awsdms_ apply_exception, awsdms_apply,
    /// awsdms_changes) are created for the specified file group.
    control_tables_file_group: ?[]const u8 = null,

    /// Database name for the endpoint.
    database_name: ?[]const u8 = null,

    /// Forces LOB lookup on inline LOB.
    force_lob_lookup: ?bool = null,

    /// Endpoint connection password.
    password: ?[]const u8 = null,

    /// Endpoint TCP port.
    port: ?i32 = null,

    /// Cleans and recreates table metadata information on the replication instance
    /// when a
    /// mismatch occurs. An example is a situation where running an alter DDL
    /// statement on a table
    /// might result in different information about the table cached in the
    /// replication
    /// instance.
    query_single_always_on_node: ?bool = null,

    /// When this attribute is set to `Y`, DMS only reads changes from transaction
    /// log backups and doesn't read from the active transaction log file during
    /// ongoing
    /// replication. Setting this parameter to `Y` enables you to control active
    /// transaction log file growth during full load and ongoing replication tasks.
    /// However, it can
    /// add some source latency to ongoing replication.
    read_backup_only: ?bool = null,

    /// Use this attribute to minimize the need to access the backup log and enable
    /// DMS to
    /// prevent truncation using one of the following two methods.
    ///
    /// *Start transactions in the database:* This is the default method.
    /// When this method is used, DMS prevents TLOG truncation by mimicking a
    /// transaction in the
    /// database. As long as such a transaction is open, changes that appear after
    /// the transaction
    /// started aren't truncated. If you need Microsoft Replication to be enabled in
    /// your database,
    /// then you must choose this method.
    ///
    /// *Exclusively use sp_repldone within a single task*: When this method
    /// is used, DMS reads the changes and then uses sp_repldone to mark the TLOG
    /// transactions as
    /// ready for truncation. Although this method doesn't involve any transactional
    /// activities, it
    /// can only be used when Microsoft Replication isn't running. Also, when using
    /// this method,
    /// only one DMS task can access the database at any given time. Therefore, if
    /// you need to
    /// run parallel DMS tasks against the same database, use the default method.
    safeguard_policy: ?SafeguardPolicy = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the SQL Server endpoint.
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
    /// that contains the SQL Server endpoint connection details.
    secrets_manager_secret_id: ?[]const u8 = null,

    /// Fully qualified domain name of the endpoint. For an Amazon RDS SQL Server
    /// instance, this is
    /// the output of
    /// [DescribeDBInstances](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBInstances.html), in the `
    /// [Endpoint](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_Endpoint.html).Address` field.
    server_name: ?[]const u8 = null,

    /// Indicates the mode used to fetch CDC data.
    tlog_access_mode: ?TlogAccessMode = null,

    /// Use the `TrimSpaceInChar` source endpoint setting to right-trim data on CHAR
    /// and NCHAR data types during migration. Setting `TrimSpaceInChar` does not
    /// left-trim data. The default value is `true`.
    trim_space_in_char: ?bool = null,

    /// Use this to attribute to transfer data for full-load operations using BCP.
    /// When the
    /// target table contains an identity column that does not exist in the source
    /// table, you must
    /// disable the use BCP for loading table option.
    use_bcp_full_load: ?bool = null,

    /// Endpoint connection user name.
    username: ?[]const u8 = null,

    /// When this attribute is set to `Y`, DMS processes third-party transaction log
    /// backups if they are created in native format.
    use_third_party_backup_device: ?bool = null,

    pub const json_field_names = .{
        .authentication_method = "AuthenticationMethod",
        .bcp_packet_size = "BcpPacketSize",
        .control_tables_file_group = "ControlTablesFileGroup",
        .database_name = "DatabaseName",
        .force_lob_lookup = "ForceLobLookup",
        .password = "Password",
        .port = "Port",
        .query_single_always_on_node = "QuerySingleAlwaysOnNode",
        .read_backup_only = "ReadBackupOnly",
        .safeguard_policy = "SafeguardPolicy",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .tlog_access_mode = "TlogAccessMode",
        .trim_space_in_char = "TrimSpaceInChar",
        .use_bcp_full_load = "UseBcpFullLoad",
        .username = "Username",
        .use_third_party_backup_device = "UseThirdPartyBackupDevice",
    };
};
