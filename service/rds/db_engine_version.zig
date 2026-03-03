const CharacterSet = @import("character_set.zig").CharacterSet;
const CustomDBEngineVersionAMI = @import("custom_db_engine_version_ami.zig").CustomDBEngineVersionAMI;
const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const Timezone = @import("timezone.zig").Timezone;
const Tag = @import("tag.zig").Tag;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;

/// This data type is used as a response element in the action
/// `DescribeDBEngineVersions`.
pub const DBEngineVersion = struct {
    /// The creation time of the DB engine version.
    create_time: ?i64 = null,

    /// JSON string that lists the installation files and parameters that RDS Custom
    /// uses to create a custom engine version (CEV). RDS Custom applies the patches
    /// in the order in which they're listed in the manifest. You can set the Oracle
    /// home, Oracle base, and UNIX/Linux user and group using the installation
    /// parameters. For more information, see [JSON fields in the CEV
    /// manifest](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-cev.preparing.html#custom-cev.preparing.manifest.fields) in the *Amazon RDS User Guide*.
    custom_db_engine_version_manifest: ?[]const u8 = null,

    /// The database installation files (ISO and EXE) uploaded to Amazon S3 for your
    /// database engine version to import to Amazon RDS. Required for
    /// `sqlserver-dev-ee`.
    database_installation_files: ?[]const []const u8 = null,

    /// The name of the Amazon S3 bucket that contains your database installation
    /// files.
    database_installation_files_s3_bucket_name: ?[]const u8 = null,

    /// The Amazon S3 directory that contains the database installation files. If
    /// not specified, then no prefix is assumed.
    database_installation_files_s3_prefix: ?[]const u8 = null,

    /// The description of the database engine.
    db_engine_description: ?[]const u8 = null,

    /// A value that indicates the source media provider of the AMI based on the
    /// usage operation. Applicable for RDS Custom for SQL Server.
    db_engine_media_type: ?[]const u8 = null,

    /// The ARN of the custom engine version.
    db_engine_version_arn: ?[]const u8 = null,

    /// The description of the database engine version.
    db_engine_version_description: ?[]const u8 = null,

    /// The name of the DB parameter group family for the database engine.
    db_parameter_group_family: ?[]const u8 = null,

    /// The default character set for new instances of this engine version, if the
    /// `CharacterSetName` parameter of the CreateDBInstance API isn't specified.
    default_character_set: ?CharacterSet = null,

    /// The name of the database engine.
    engine: ?[]const u8 = null,

    /// The version number of the database engine.
    engine_version: ?[]const u8 = null,

    /// The types of logs that the database engine has available for export to
    /// CloudWatch Logs.
    exportable_log_types: ?[]const []const u8 = null,

    /// The reason that the custom engine version creation for `sqlserver-dev-ee`
    /// failed with an `incompatible-installation-media` status.
    failure_reason: ?[]const u8 = null,

    /// The EC2 image
    image: ?CustomDBEngineVersionAMI = null,

    /// The Amazon Web Services KMS key identifier for an encrypted CEV. This
    /// parameter is required for RDS Custom, but optional for Amazon RDS.
    kms_key_id: ?[]const u8 = null,

    /// The major engine version of the CEV.
    major_engine_version: ?[]const u8 = null,

    /// Specifies any Aurora Serverless v2 properties or limits that differ between
    /// Aurora engine versions. You can test the values of this attribute when
    /// deciding which Aurora version to use in a new or upgraded DB cluster. You
    /// can also retrieve the version of an existing DB cluster and check whether
    /// that version supports certain Aurora Serverless v2 features before you
    /// attempt to use those features.
    serverless_v2_features_support: ?ServerlessV2FeaturesSupport = null,

    /// The status of the DB engine version, either `available` or `deprecated`.
    status: ?[]const u8 = null,

    /// A list of the supported CA certificate identifiers.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    supported_ca_certificate_identifiers: ?[]const []const u8 = null,

    /// A list of the character sets supported by this engine for the
    /// `CharacterSetName` parameter of the `CreateDBInstance` operation.
    supported_character_sets: ?[]const CharacterSet = null,

    /// A list of the supported DB engine modes.
    supported_engine_modes: ?[]const []const u8 = null,

    /// A list of features supported by the DB engine.
    ///
    /// The supported features vary by DB engine and DB engine version.
    ///
    /// To determine the supported features for a specific DB engine and DB engine
    /// version using the CLI, use the following command:
    ///
    /// `aws rds describe-db-engine-versions --engine <engine_name> --engine-version
    /// <engine_version>`
    ///
    /// For example, to determine the supported features for RDS for PostgreSQL
    /// version 13.3 using the CLI, use the following command:
    ///
    /// `aws rds describe-db-engine-versions --engine postgres --engine-version
    /// 13.3`
    ///
    /// The supported features are listed under `SupportedFeatureNames` in the
    /// output.
    supported_feature_names: ?[]const []const u8 = null,

    /// A list of the character sets supported by the Oracle DB engine for the
    /// `NcharCharacterSetName` parameter of the `CreateDBInstance` operation.
    supported_nchar_character_sets: ?[]const CharacterSet = null,

    /// A list of the time zones supported by this engine for the `Timezone`
    /// parameter of the `CreateDBInstance` action.
    supported_timezones: ?[]const Timezone = null,

    /// Indicates whether the engine version supports Babelfish for Aurora
    /// PostgreSQL.
    supports_babelfish: ?bool = null,

    /// Indicates whether the engine version supports rotating the server
    /// certificate without rebooting the DB instance.
    supports_certificate_rotation_without_restart: ?bool = null,

    /// Indicates whether you can use Aurora global databases with a specific DB
    /// engine version.
    supports_global_databases: ?bool = null,

    /// Indicates whether the DB engine version supports zero-ETL integrations with
    /// Amazon Redshift.
    supports_integrations: ?bool = null,

    /// Indicates whether the DB engine version supports Aurora Limitless Database.
    supports_limitless_database: ?bool = null,

    /// Indicates whether the DB engine version supports forwarding write operations
    /// from reader DB instances to the writer DB instance in the DB cluster. By
    /// default, write operations aren't allowed on reader DB instances.
    ///
    /// Valid for: Aurora DB clusters only
    supports_local_write_forwarding: ?bool = null,

    /// Indicates whether the engine version supports exporting the log types
    /// specified by ExportableLogTypes to CloudWatch Logs.
    supports_log_exports_to_cloudwatch_logs: ?bool = null,

    /// Indicates whether you can use Aurora parallel query with a specific DB
    /// engine version.
    supports_parallel_query: ?bool = null,

    /// Indicates whether the database engine version supports read replicas.
    supports_read_replica: ?bool = null,

    tag_list: ?[]const Tag = null,

    /// A list of engine versions that this database engine version can be upgraded
    /// to.
    valid_upgrade_target: ?[]const UpgradeTarget = null,
};
