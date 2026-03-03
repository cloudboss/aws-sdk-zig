const OracleAuthenticationMethod = @import("oracle_authentication_method.zig").OracleAuthenticationMethod;
const CharLengthSemantics = @import("char_length_semantics.zig").CharLengthSemantics;

/// Provides information that defines an Oracle endpoint.
pub const OracleSettings = struct {
    /// Set this attribute to `false` in order to use the Binary Reader to capture
    /// change data for an Amazon RDS for Oracle as the source. This tells the DMS
    /// instance to not
    /// access redo logs through any specified path prefix replacement using direct
    /// file
    /// access.
    access_alternate_directly: ?bool = null,

    /// Set this attribute with `ArchivedLogDestId` in a primary/ standby setup.
    /// This
    /// attribute is useful in the case of a switchover. In this case, DMS needs to
    /// know which
    /// destination to get archive redo logs from to read changes. This need arises
    /// because the
    /// previous primary instance is now a standby instance after switchover.
    ///
    /// Although DMS supports the use of the Oracle `RESETLOGS` option to open the
    /// database, never use `RESETLOGS` unless necessary. For additional information
    /// about `RESETLOGS`, see [RMAN Data Repair
    /// Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/19/bradv/rman-data-repair-concepts.html#GUID-1805CCF7-4AF2-482D-B65A-998192F89C2B) in the *Oracle Database Backup and Recovery
    /// User's Guide*.
    additional_archived_log_dest_id: ?i32 = null,

    /// Set this attribute to set up table-level supplemental logging for the Oracle
    /// database.
    /// This attribute enables PRIMARY KEY supplemental logging on all tables
    /// selected for a
    /// migration task.
    ///
    /// If you use this option, you still need to enable database-level supplemental
    /// logging.
    add_supplemental_logging: ?bool = null,

    /// Set this attribute to `true` to enable replication of Oracle tables
    /// containing columns that are nested tables or defined types.
    allow_select_nested_tables: ?bool = null,

    /// Specifies the ID of the destination for the archived redo logs. This value
    /// should be the
    /// same as a number in the dest_id column of the v$archived_log view. If you
    /// work with an
    /// additional redo log destination, use the `AdditionalArchivedLogDestId`
    /// option to
    /// specify the additional destination ID. Doing this improves performance by
    /// ensuring that the
    /// correct logs are accessed from the outset.
    archived_log_dest_id: ?i32 = null,

    /// When this field is set to `True`, DMS only accesses the archived redo logs.
    /// If the archived redo logs are stored on Automatic Storage Management (ASM)
    /// only, the DMS
    /// user account needs to be granted ASM privileges.
    archived_logs_only: ?bool = null,

    /// For an Oracle source endpoint, your Oracle Automatic Storage Management
    /// (ASM) password.
    /// You can set this value from the `
    /// *asm_user_password*
    /// ` value.
    /// You set this value as part of the comma-separated value that you set to the
    /// `Password` request parameter when you create the endpoint to access
    /// transaction logs using Binary Reader. For more information, see
    /// [Configuration for change data capture (CDC) on an Oracle source
    /// database](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC.Configuration).
    asm_password: ?[]const u8 = null,

    /// For an Oracle source endpoint, your ASM server address. You can set this
    /// value from the
    /// `asm_server` value. You set `asm_server` as part of the extra
    /// connection attribute string to access an Oracle server with Binary Reader
    /// that uses ASM.
    /// For more information, see [Configuration for change data capture (CDC) on an
    /// Oracle source
    /// database](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC.Configuration).
    asm_server: ?[]const u8 = null,

    /// For an Oracle source endpoint, your ASM user name. You can set this value
    /// from the
    /// `asm_user` value. You set `asm_user` as part of the extra
    /// connection attribute string to access an Oracle server with Binary Reader
    /// that uses ASM.
    /// For more information, see [Configuration for change data capture (CDC) on an
    /// Oracle source
    /// database](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC.Configuration).
    asm_user: ?[]const u8 = null,

    /// Specifies the authentication method to be used with Oracle.
    authentication_method: ?OracleAuthenticationMethod = null,

    /// Specifies whether the length of a character column is in bytes or in
    /// characters. To
    /// indicate that the character column length is in characters, set this
    /// attribute to
    /// `CHAR`. Otherwise, the character column length is in bytes.
    ///
    /// Example: `charLengthSemantics=CHAR;`
    char_length_semantics: ?CharLengthSemantics = null,

    /// When true, converts timestamps with the `timezone` datatype to their UTC
    /// value.
    convert_timestamp_with_zone_to_utc: ?bool = null,

    /// Database name for the endpoint.
    database_name: ?[]const u8 = null,

    /// When set to `true`, this attribute helps to increase the commit rate on the
    /// Oracle target database by writing directly to tables and not writing a trail
    /// to database
    /// logs.
    direct_path_no_log: ?bool = null,

    /// When set to `true`, this attribute specifies a parallel load when
    /// `useDirectPathFullLoad` is set to `Y`. This attribute also only
    /// applies when you use the DMS parallel load feature. Note that the target
    /// table cannot
    /// have any constraints or indexes.
    direct_path_parallel_load: ?bool = null,

    /// Set this attribute to enable homogenous tablespace replication and create
    /// existing
    /// tables or indexes under the same tablespace on the target.
    enable_homogenous_tablespace: ?bool = null,

    /// Specifies the IDs of one more destinations for one or more archived redo
    /// logs. These IDs
    /// are the values of the `dest_id` column in the `v$archived_log` view.
    /// Use this setting with the `archivedLogDestId` extra connection attribute in
    /// a
    /// primary-to-single setup or a primary-to-multiple-standby setup.
    ///
    /// This setting is useful in a switchover when you use an Oracle Data Guard
    /// database as a
    /// source. In this case, DMS needs information about what destination to get
    /// archive redo
    /// logs from to read changes. DMS needs this because after the switchover the
    /// previous
    /// primary is a standby instance. For example, in a primary-to-single standby
    /// setup you might
    /// apply the following settings.
    ///
    /// `archivedLogDestId=1; ExtraArchivedLogDestIds=[2]`
    ///
    /// In a primary-to-multiple-standby setup, you might apply the following
    /// settings.
    ///
    /// `archivedLogDestId=1; ExtraArchivedLogDestIds=[2,3,4]`
    ///
    /// Although DMS supports the use of the Oracle `RESETLOGS` option to open the
    /// database, never use `RESETLOGS` unless it's necessary. For more information
    /// about `RESETLOGS`, see [ RMAN Data Repair
    /// Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/19/bradv/rman-data-repair-concepts.html#GUID-1805CCF7-4AF2-482D-B65A-998192F89C2B) in the *Oracle Database Backup and Recovery
    /// User's Guide*.
    extra_archived_log_dest_ids: ?[]const i32 = null,

    /// When set to `true`, this attribute causes a task to fail if the actual size
    /// of an LOB column is greater than the specified `LobMaxSize`.
    ///
    /// If a task is set to limited LOB mode and this option is set to `true`, the
    /// task fails instead of truncating the LOB data.
    fail_tasks_on_lob_truncation: ?bool = null,

    /// Specifies the number scale. You can select a scale up to 38, or you can
    /// select FLOAT. By
    /// default, the NUMBER data type is converted to precision 38, scale 10.
    ///
    /// Example: `numberDataTypeScale=12`
    number_datatype_scale: ?i32 = null,

    /// The timeframe in minutes to check for open transactions for a CDC-only task.
    ///
    /// You can specify an integer value between 0 (the default) and 240 (the
    /// maximum).
    ///
    /// This parameter is only valid in DMS version 3.5.0 and later.
    open_transaction_window: ?i32 = null,

    /// Set this string attribute to the required value in order to use the Binary
    /// Reader to
    /// capture change data for an Amazon RDS for Oracle as the source. This value
    /// specifies the
    /// default Oracle root used to access the redo logs.
    oracle_path_prefix: ?[]const u8 = null,

    /// Set this attribute to change the number of threads that DMS configures to
    /// perform a
    /// change data capture (CDC) load using Oracle Automatic Storage Management
    /// (ASM). You can
    /// specify an integer value between 2 (the default) and 8 (the maximum). Use
    /// this attribute
    /// together with the `readAheadBlocks` attribute.
    parallel_asm_read_threads: ?i32 = null,

    /// Endpoint connection password.
    password: ?[]const u8 = null,

    /// Endpoint TCP port.
    port: ?i32 = null,

    /// Set this attribute to change the number of read-ahead blocks that DMS
    /// configures to
    /// perform a change data capture (CDC) load using Oracle Automatic Storage
    /// Management (ASM).
    /// You can specify an integer value between 1000 (the default) and 200,000 (the
    /// maximum).
    read_ahead_blocks: ?i32 = null,

    /// When set to `true`, this attribute supports tablespace replication.
    read_table_space_name: ?bool = null,

    /// Set this attribute to true in order to use the Binary Reader to capture
    /// change data for
    /// an Amazon RDS for Oracle as the source. This setting tells DMS instance to
    /// replace the default
    /// Oracle root with the specified `usePathPrefix` setting to access the redo
    /// logs.
    replace_path_prefix: ?bool = null,

    /// Specifies the number of seconds that the system waits before resending a
    /// query.
    ///
    /// Example: `retryInterval=6;`
    retry_interval: ?i32 = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the Oracle endpoint.
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

    /// Required only if your Oracle endpoint uses Automatic Storage Management
    /// (ASM). The full
    /// ARN of the IAM role that specifies DMS as the trusted entity and grants the
    /// required
    /// permissions to access the `SecretsManagerOracleAsmSecret`. This
    /// `SecretsManagerOracleAsmSecret` has the secret value that allows access to
    /// the Oracle ASM of the endpoint.
    ///
    /// You can specify one of two sets of values for these permissions. You can
    /// specify the
    /// values for this setting and `SecretsManagerOracleAsmSecretId`. Or you can
    /// specify clear-text values for `AsmUser`, `AsmPassword`, and
    /// `AsmServerName`. You can't specify both. For more information on
    /// creating this `SecretsManagerOracleAsmSecret` and the
    /// `SecretsManagerOracleAsmAccessRoleArn` and
    /// `SecretsManagerOracleAsmSecretId` required to access it, see [Using secrets
    /// to access Database Migration Service
    /// resources](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#security-iam-secretsmanager) in the
    /// *Database Migration Service User Guide*.
    secrets_manager_oracle_asm_access_role_arn: ?[]const u8 = null,

    /// Required only if your Oracle endpoint uses Automatic Storage Management
    /// (ASM). The full
    /// ARN, partial ARN, or friendly name of the `SecretsManagerOracleAsmSecret`
    /// that
    /// contains the Oracle ASM connection details for the Oracle endpoint.
    secrets_manager_oracle_asm_secret_id: ?[]const u8 = null,

    /// The full ARN, partial ARN, or friendly name of the `SecretsManagerSecret`
    /// that contains the Oracle endpoint connection details.
    secrets_manager_secret_id: ?[]const u8 = null,

    /// For an Oracle source endpoint, the transparent data encryption (TDE)
    /// password required
    /// by AWM DMS to access Oracle redo logs encrypted by TDE using Binary Reader.
    /// It is also the
    /// `
    /// *TDE_Password*
    /// ` part of the comma-separated value you
    /// set to the `Password` request parameter when you create the endpoint. The
    /// `SecurityDbEncryptian` setting is related to this
    /// `SecurityDbEncryptionName` setting. For more information, see [ Supported
    /// encryption methods for using Oracle as a source for
    /// DMS
    /// ](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.Encryption) in the *Database Migration Service User Guide*.
    security_db_encryption: ?[]const u8 = null,

    /// For an Oracle source endpoint, the name of a key used for the transparent
    /// data
    /// encryption (TDE) of the columns and tablespaces in an Oracle source database
    /// that is
    /// encrypted using TDE. The key value is the value of the
    /// `SecurityDbEncryption`
    /// setting. For more information on setting the key name value of
    /// `SecurityDbEncryptionName`, see the information and example for setting the
    /// `securityDbEncryptionName` extra connection attribute in [ Supported
    /// encryption methods for using Oracle as a source for
    /// DMS
    /// ](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.Encryption) in the *Database Migration Service User Guide*.
    security_db_encryption_name: ?[]const u8 = null,

    /// Fully qualified domain name of the endpoint.
    ///
    /// For an Amazon RDS Oracle instance, this is the output of
    /// [DescribeDBInstances](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBInstances.html), in the `
    /// [Endpoint](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_Endpoint.html).Address` field.
    server_name: ?[]const u8 = null,

    /// Use this attribute to convert `SDO_GEOMETRY` to `GEOJSON` format.
    /// By default, DMS calls the `SDO2GEOJSON` custom function if present and
    /// accessible. Or you can create your own custom function that mimics the
    /// operation of
    /// `SDOGEOJSON` and set `SpatialDataOptionToGeoJsonFunctionName` to
    /// call it instead.
    spatial_data_option_to_geo_json_function_name: ?[]const u8 = null,

    /// Use this attribute to specify a time in minutes for the delay in standby
    /// sync. If the
    /// source is an Oracle Active Data Guard standby database, use this attribute
    /// to specify the
    /// time lag between primary and standby databases.
    ///
    /// In DMS, you can create an Oracle CDC task that uses an Active Data Guard
    /// standby
    /// instance as a source for replicating ongoing changes. Doing this eliminates
    /// the need to
    /// connect to an active database that might be in production.
    standby_delay_time: ?i32 = null,

    /// Use the `TrimSpaceInChar` source endpoint setting to trim data on CHAR and
    /// NCHAR data types during migration. The default value is `true`.
    trim_space_in_char: ?bool = null,

    /// Set this attribute to `true` in order to use the Binary Reader to capture
    /// change data for an Amazon RDS for Oracle as the source. This tells the DMS
    /// instance to use any
    /// specified prefix replacement to access all online redo logs.
    use_alternate_folder_for_online: ?bool = null,

    /// Set this attribute to True to capture change data using the Binary Reader
    /// utility. Set
    /// `UseLogminerReader` to False to set this attribute to True. To use Binary
    /// Reader with Amazon RDS for Oracle as the source, you set additional
    /// attributes. For more
    /// information about using this setting with Oracle Automatic Storage
    /// Management (ASM), see
    /// [ Using Oracle LogMiner or DMS Binary Reader for
    /// CDC](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC).
    use_b_file: ?bool = null,

    /// Set this attribute to True to have DMS use a direct path full load. Specify
    /// this value
    /// to use the direct path protocol in the Oracle Call Interface (OCI). By using
    /// this OCI
    /// protocol, you can bulk-load Oracle target tables during a full load.
    use_direct_path_full_load: ?bool = null,

    /// Set this attribute to True to capture change data using the Oracle LogMiner
    /// utility (the
    /// default). Set this attribute to False if you want to access the redo logs as
    /// a binary file.
    /// When you set `UseLogminerReader` to False, also set `UseBfile` to
    /// True. For more information on this setting and using Oracle ASM, see [ Using
    /// Oracle LogMiner or DMS Binary Reader for
    /// CDC](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC) in
    /// the *DMS User Guide*.
    use_logminer_reader: ?bool = null,

    /// Set this string attribute to the required value in order to use the Binary
    /// Reader to
    /// capture change data for an Amazon RDS for Oracle as the source. This value
    /// specifies the
    /// path prefix used to replace the default Oracle root to access the redo logs.
    use_path_prefix: ?[]const u8 = null,

    /// Endpoint connection user name.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_alternate_directly = "AccessAlternateDirectly",
        .additional_archived_log_dest_id = "AdditionalArchivedLogDestId",
        .add_supplemental_logging = "AddSupplementalLogging",
        .allow_select_nested_tables = "AllowSelectNestedTables",
        .archived_log_dest_id = "ArchivedLogDestId",
        .archived_logs_only = "ArchivedLogsOnly",
        .asm_password = "AsmPassword",
        .asm_server = "AsmServer",
        .asm_user = "AsmUser",
        .authentication_method = "AuthenticationMethod",
        .char_length_semantics = "CharLengthSemantics",
        .convert_timestamp_with_zone_to_utc = "ConvertTimestampWithZoneToUTC",
        .database_name = "DatabaseName",
        .direct_path_no_log = "DirectPathNoLog",
        .direct_path_parallel_load = "DirectPathParallelLoad",
        .enable_homogenous_tablespace = "EnableHomogenousTablespace",
        .extra_archived_log_dest_ids = "ExtraArchivedLogDestIds",
        .fail_tasks_on_lob_truncation = "FailTasksOnLobTruncation",
        .number_datatype_scale = "NumberDatatypeScale",
        .open_transaction_window = "OpenTransactionWindow",
        .oracle_path_prefix = "OraclePathPrefix",
        .parallel_asm_read_threads = "ParallelAsmReadThreads",
        .password = "Password",
        .port = "Port",
        .read_ahead_blocks = "ReadAheadBlocks",
        .read_table_space_name = "ReadTableSpaceName",
        .replace_path_prefix = "ReplacePathPrefix",
        .retry_interval = "RetryInterval",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_oracle_asm_access_role_arn = "SecretsManagerOracleAsmAccessRoleArn",
        .secrets_manager_oracle_asm_secret_id = "SecretsManagerOracleAsmSecretId",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .security_db_encryption = "SecurityDbEncryption",
        .security_db_encryption_name = "SecurityDbEncryptionName",
        .server_name = "ServerName",
        .spatial_data_option_to_geo_json_function_name = "SpatialDataOptionToGeoJsonFunctionName",
        .standby_delay_time = "StandbyDelayTime",
        .trim_space_in_char = "TrimSpaceInChar",
        .use_alternate_folder_for_online = "UseAlternateFolderForOnline",
        .use_b_file = "UseBFile",
        .use_direct_path_full_load = "UseDirectPathFullLoad",
        .use_logminer_reader = "UseLogminerReader",
        .use_path_prefix = "UsePathPrefix",
        .username = "Username",
    };
};
