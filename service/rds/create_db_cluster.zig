const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterScalabilityType = @import("cluster_scalability_type.zig").ClusterScalabilityType;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const MasterUserAuthenticationType = @import("master_user_authentication_type.zig").MasterUserAuthenticationType;
const RdsCustomClusterConfiguration = @import("rds_custom_cluster_configuration.zig").RdsCustomClusterConfiguration;
const ScalingConfiguration = @import("scaling_configuration.zig").ScalingConfiguration;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const CreateDBClusterInput = struct {
    /// The amount of storage in gibibytes (GiB) to allocate to each DB instance in
    /// the Multi-AZ DB cluster.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    ///
    /// This setting is required to create a Multi-AZ DB cluster.
    allocated_storage: ?i32 = null,

    /// Specifies whether minor engine upgrades are applied automatically to the DB
    /// cluster during the maintenance window. By default, minor engine upgrades are
    /// applied automatically.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB cluster.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// A list of Availability Zones (AZs) where you specifically want to create DB
    /// instances in the DB cluster.
    ///
    /// For the first three DB instances that you create, RDS distributes each DB
    /// instance to a different AZ that you specify. For additional DB instances
    /// that you create, RDS randomly distributes them to the AZs that you
    /// specified. For example, if you create a DB cluster with one writer instance
    /// and three reader instances, RDS might distribute the writer instance to AZ
    /// 1, the first reader instance to AZ 2, the second reader instance to AZ 3,
    /// and the third reader instance to either AZ 1, AZ 2, or AZ 3.
    ///
    /// For more information, see [Availability
    /// Zones](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.RegionsAndAvailabilityZones.html#Concepts.RegionsAndAvailabilityZones.AvailabilityZones) and [High availability for Aurora DB instances](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html#Concepts.AuroraHighAvailability.Instances) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    ///
    /// Constraints:
    ///
    /// * Can't specify more than three AZs.
    availability_zones: ?[]const []const u8 = null,

    /// The target backtrack window, in seconds. To disable backtracking, set this
    /// value to `0`.
    ///
    /// Valid for Cluster Type: Aurora MySQL DB clusters only
    ///
    /// Default: `0`
    ///
    /// Constraints:
    ///
    /// * If specified, this value must be set to a number from 0 to 259,200 (72
    ///   hours).
    backtrack_window: ?i64 = null,

    /// The number of days for which automated backups are retained.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Default: `1`
    ///
    /// Constraints:
    ///
    /// * Must be a value from 1 to 35.
    backup_retention_period: ?i32 = null,

    /// The CA certificate identifier to use for the DB cluster's server
    /// certificate.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters
    ca_certificate_identifier: ?[]const u8 = null,

    /// The name of the character set (`CharacterSet`) to associate the DB cluster
    /// with.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    character_set_name: ?[]const u8 = null,

    /// Specifies the scalability mode of the Aurora DB cluster. When set to
    /// `limitless`, the cluster operates as an Aurora Limitless Database. When set
    /// to `standard` (the default), the cluster uses normal DB instance creation.
    ///
    /// Valid for: Aurora DB clusters only
    ///
    /// You can't modify this setting after you create the DB cluster.
    cluster_scalability_type: ?ClusterScalabilityType = null,

    /// Specifies whether to copy all tags from the DB cluster to snapshots of the
    /// DB cluster. The default is not to copy them.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    copy_tags_to_snapshot: ?bool = null,

    /// The mode of Database Insights to enable for the DB cluster.
    ///
    /// If you set this value to `advanced`, you must also set the
    /// `PerformanceInsightsEnabled` parameter to `true` and the
    /// `PerformanceInsightsRetentionPeriod` parameter to 465.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The name for your database of up to 64 alphanumeric characters. A database
    /// named `postgres` is always created. If this parameter is specified, an
    /// additional database with this name is created.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    database_name: ?[]const u8 = null,

    /// The identifier for this DB cluster. This parameter is stored as a lowercase
    /// string.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 (for Aurora DB clusters) or 1 to 52 (for
    ///   Multi-AZ DB clusters) letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster1`
    db_cluster_identifier: []const u8,

    /// The compute and memory capacity of each DB instance in the Multi-AZ DB
    /// cluster, for example `db.m6gd.xlarge`. Not all DB instance classes are
    /// available in all Amazon Web Services Regions, or for all database engines.
    ///
    /// For the full list of DB instance classes and availability for your engine,
    /// see [DB instance
    /// class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting is required to create a Multi-AZ DB cluster.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    db_cluster_instance_class: ?[]const u8 = null,

    /// The name of the DB cluster parameter group to associate with this DB
    /// cluster. If you don't specify a value, then the default DB cluster parameter
    /// group for the specified DB engine and version is used.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing DB cluster parameter
    ///   group.
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// A DB subnet group to associate with this DB cluster.
    ///
    /// This setting is required to create a Multi-AZ DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must match the name of an existing DB subnet group.
    ///
    /// Example: `mydbsubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Reserved for future use.
    db_system_id: ?[]const u8 = null,

    /// Specifies whether the DB cluster has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    deletion_protection: ?bool = null,

    /// The Active Directory directory ID to create the DB cluster in.
    ///
    /// For Amazon Aurora DB clusters, Amazon RDS can use Kerberos authentication to
    /// authenticate users that connect to the DB cluster.
    ///
    /// For more information, see [Kerberos
    /// authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/kerberos-authentication.html) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    domain: ?[]const u8 = null,

    /// The name of the IAM role to use when making API calls to the Directory
    /// Service.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    domain_iam_role_name: ?[]const u8 = null,

    /// The list of log types that need to be enabled for exporting to CloudWatch
    /// Logs.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// The following values are valid for each DB engine:
    ///
    /// * Aurora MySQL - `audit | error | general | instance | slowquery |
    ///   iam-db-auth-error`
    /// * Aurora PostgreSQL - `instance | postgresql | iam-db-auth-error`
    /// * RDS for MySQL - `error | general | slowquery | iam-db-auth-error`
    /// * RDS for PostgreSQL - `postgresql | upgrade | iam-db-auth-error`
    ///
    /// For more information about exporting CloudWatch Logs for Amazon RDS, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// For more information about exporting CloudWatch Logs for Amazon Aurora, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Aurora User Guide*.
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies whether to enable this DB cluster to forward write operations to
    /// the primary cluster of a global cluster (Aurora global database). By
    /// default, write operations are not allowed on Aurora DB clusters that are
    /// secondary clusters in an Aurora global database.
    ///
    /// You can set this value only on Aurora DB clusters that are members of an
    /// Aurora global database. With this parameter enabled, a secondary cluster can
    /// forward writes to the current primary cluster, and the resulting changes are
    /// replicated back to this cluster. For the primary DB cluster of an Aurora
    /// global database, this value is used immediately if the primary is demoted by
    /// a global cluster API operation, but it does nothing until then.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    enable_global_write_forwarding: ?bool = null,

    /// Specifies whether to enable the HTTP endpoint for the DB cluster. By
    /// default, the HTTP endpoint isn't enabled.
    ///
    /// When enabled, the HTTP endpoint provides a connectionless web service API
    /// (RDS Data API) for running SQL queries on the DB cluster. You can also query
    /// your database from inside the RDS console with the RDS query editor.
    ///
    /// For more information, see [Using RDS Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    enable_http_endpoint: ?bool = null,

    /// Specifies whether to enable mapping of Amazon Web Services Identity and
    /// Access Management (IAM) accounts to database accounts. By default, mapping
    /// isn't enabled.
    ///
    /// For more information, see [ IAM Database
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon Aurora User Guide* or [IAM database authentication for MariaDB, MySQL, and PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    enable_iam_database_authentication: ?bool = null,

    /// Specifies whether to enable Aurora Limitless Database. You must enable
    /// Aurora Limitless Database to create a DB shard group.
    ///
    /// Valid for: Aurora DB clusters only
    ///
    /// This setting is no longer used. Instead use the `ClusterScalabilityType`
    /// setting.
    enable_limitless_database: ?bool = null,

    /// Specifies whether read replicas can forward write operations to the writer
    /// DB instance in the DB cluster. By default, write operations aren't allowed
    /// on reader DB instances.
    ///
    /// Valid for: Aurora DB clusters only
    enable_local_write_forwarding: ?bool = null,

    /// Specifies whether to turn on Performance Insights for the DB cluster.
    ///
    /// For more information, see [ Using Amazon Performance
    /// Insights](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    enable_performance_insights: ?bool = null,

    /// The database engine to use for this DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    /// * `mysql`
    /// * `postgres`
    /// * `neptune` - For information about using Amazon Neptune, see the [ *Amazon
    ///   Neptune User Guide*
    ///   ](https://docs.aws.amazon.com/neptune/latest/userguide/intro.html).
    engine: []const u8,

    /// The life cycle type for this DB cluster.
    ///
    /// By default, this value is set to `open-source-rds-extended-support`, which
    /// enrolls your DB cluster into Amazon RDS Extended Support. At the end of
    /// standard support, you can avoid charges for Extended Support by setting the
    /// value to `open-source-rds-extended-support-disabled`. In this case, creating
    /// the DB cluster will fail if the DB major version is past its end of standard
    /// support date.
    ///
    /// You can use this setting to enroll your DB cluster into Amazon RDS Extended
    /// Support. With RDS Extended Support, you can run the selected major engine
    /// version on your DB cluster past the end of standard support for that engine
    /// version. For more information, see the following sections:
    ///
    /// * Amazon Aurora - [Amazon RDS Extended Support with Amazon
    ///   Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/extended-support.html) in the *Amazon Aurora User Guide*
    /// * Amazon RDS - [Amazon RDS Extended Support with Amazon
    ///   RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/extended-support.html) in the *Amazon RDS User Guide*
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values: `open-source-rds-extended-support |
    /// open-source-rds-extended-support-disabled`
    ///
    /// Default: `open-source-rds-extended-support`
    engine_lifecycle_support: ?[]const u8 = null,

    /// The DB engine mode of the DB cluster, either `provisioned` or `serverless`.
    ///
    /// The `serverless` engine mode only applies for Aurora Serverless v1 DB
    /// clusters. Aurora Serverless v2 DB clusters use the `provisioned` engine
    /// mode.
    ///
    /// For information about limitations and requirements for Serverless DB
    /// clusters, see the following sections in the *Amazon Aurora User Guide*:
    ///
    /// * [Limitations of Aurora Serverless
    ///   v1](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html#aurora-serverless.limitations)
    /// * [Requirements for Aurora Serverless
    ///   v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.requirements.html)
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    engine_mode: ?[]const u8 = null,

    /// The version number of the database engine to use.
    ///
    /// To list all of the available engine versions for Aurora MySQL version 2
    /// (5.7-compatible) and version 3 (MySQL 8.0-compatible), use the following
    /// command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-mysql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// You can supply either `5.7` or `8.0` to use the default engine version for
    /// Aurora MySQL version 2 or version 3, respectively.
    ///
    /// To list all of the available engine versions for Aurora PostgreSQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-postgresql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// To list all of the available engine versions for RDS for MySQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine mysql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// To list all of the available engine versions for RDS for PostgreSQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine postgres --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// For information about a specific engine, see the following topics:
    ///
    /// * Aurora MySQL - see [Database engine updates for Amazon Aurora
    ///   MySQL](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Updates.html) in the *Amazon Aurora User Guide*.
    /// * Aurora PostgreSQL - see [Amazon Aurora PostgreSQL releases and engine
    ///   versions](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Updates.20180305.html) in the *Amazon Aurora User Guide*.
    /// * RDS for MySQL - see [Amazon RDS for
    ///   MySQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the *Amazon RDS User Guide*.
    /// * RDS for PostgreSQL - see [Amazon RDS for
    ///   PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    engine_version: ?[]const u8 = null,

    /// The global cluster ID of an Aurora cluster that becomes the primary cluster
    /// in the new global database cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    global_cluster_identifier: ?[]const u8 = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to be
    /// initially allocated for each DB instance in the Multi-AZ DB cluster.
    ///
    /// For information about valid IOPS values, see [Provisioned IOPS
    /// storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the *Amazon RDS User Guide*.
    ///
    /// This setting is required to create a Multi-AZ DB cluster.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    ///
    /// Constraints:
    ///
    /// * Must be a multiple between .5 and 50 of the storage amount for the DB
    ///   cluster.
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key identifier for an encrypted DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// When a KMS key isn't specified in `KmsKeyId`:
    ///
    /// * If `ReplicationSourceIdentifier` identifies an encrypted source, then
    ///   Amazon RDS uses the KMS key used to encrypt the source. Otherwise, Amazon
    ///   RDS uses your default KMS key.
    /// * If the `StorageEncrypted` parameter is enabled and
    ///   `ReplicationSourceIdentifier` isn't specified, then Amazon RDS uses your
    ///   default KMS key.
    ///
    /// There is a default KMS key for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    ///
    /// If you create a read replica of an encrypted DB cluster in another Amazon
    /// Web Services Region, make sure to set `KmsKeyId` to a KMS key identifier
    /// that is valid in the destination Amazon Web Services Region. This KMS key is
    /// used to encrypt the read replica in that Amazon Web Services Region.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Can't manage the master user password with Amazon Web Services Secrets
    ///   Manager if `MasterUserPassword` is specified.
    manage_master_user_password: ?bool = null,

    /// Specifies the authentication type for the master user. With IAM master user
    /// authentication, you can configure the master DB user with IAM database
    /// authentication when you create a DB cluster.
    ///
    /// You can specify one of the following values:
    ///
    /// * `password` - Use standard database authentication with a password.
    /// * `iam-db-auth` - Use IAM database authentication for the master user.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// This option is only valid for RDS for PostgreSQL and Aurora PostgreSQL
    /// engines.
    master_user_authentication_type: ?MasterUserAuthenticationType = null,

    /// The name of the master user for the DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 16 letters or numbers.
    /// * First character must be a letter.
    /// * Can't be a reserved word for the chosen database engine.
    master_username: ?[]const u8 = null,

    /// The password for the master database user.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must contain from 8 to 41 characters.
    /// * Can contain any printable ASCII character except "/", """, or "@".
    /// * Can't be specified if `ManageMasterUserPassword` is turned on.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// If you don't specify `MasterUserSecretKmsKeyId`, then the
    /// `aws/secretsmanager` KMS key is used to encrypt the secret. If the secret is
    /// in a different Amazon Web Services account, then you can't use the
    /// `aws/secretsmanager` KMS key to encrypt the secret, and you must use a
    /// customer managed KMS key.
    ///
    /// There is a default KMS key for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    master_user_secret_kms_key_id: ?[]const u8 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB cluster. To turn off collecting Enhanced Monitoring
    /// metrics, specify `0`.
    ///
    /// If `MonitoringRoleArn` is specified, also set `MonitoringInterval` to a
    /// value other than `0`.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values: `0 | 1 | 5 | 10 | 15 | 30 | 60`
    ///
    /// Default: `0`
    monitoring_interval: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the IAM role that permits RDS to send
    /// Enhanced Monitoring metrics to Amazon CloudWatch Logs. An example is
    /// `arn:aws:iam:123456789012:role/emaccess`. For information on creating a
    /// monitoring role, see [Setting up and enabling Enhanced
    /// Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the *Amazon RDS User Guide*.
    ///
    /// If `MonitoringInterval` is set to a value other than `0`, supply a
    /// `MonitoringRoleArn` value.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    monitoring_role_arn: ?[]const u8 = null,

    /// The network type of the DB cluster.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the DB
    /// cluster. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    ///
    /// Valid Values: `IPV4 | DUAL`
    network_type: ?[]const u8 = null,

    /// The option group to associate the DB cluster with.
    ///
    /// DB clusters are associated with a default option group that can't be
    /// modified.
    option_group_name: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for encryption of Performance
    /// Insights data.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// If you don't specify a value for `PerformanceInsightsKMSKeyId`, then Amazon
    /// RDS uses your default KMS key. There is a default KMS key for your Amazon
    /// Web Services account. Your Amazon Web Services account has a different
    /// default KMS key for each Amazon Web Services Region.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The number of days to retain Performance Insights data.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values:
    ///
    /// * `7`
    /// * *month* * 31, where *month* is a number of months from 1-23. Examples:
    ///   `93` (3 months * 31), `341` (11 months * 31), `589` (19 months * 31)
    /// * `731`
    ///
    /// Default: `7` days
    ///
    /// If you specify a retention period that isn't valid, such as `94`, Amazon RDS
    /// issues an error.
    performance_insights_retention_period: ?i32 = null,

    /// The port number on which the instances in the DB cluster accept connections.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values: `1150-65535`
    ///
    /// Default:
    ///
    /// * RDS for MySQL and Aurora MySQL - `3306`
    /// * RDS for PostgreSQL and Aurora PostgreSQL - `5432`
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled using the `BackupRetentionPeriod` parameter.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region. To view the time blocks available,
    /// see [ Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.Backups.BackupWindow) in the *Amazon Aurora User Guide*.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region, occurring on a random day of the
    /// week. To see the time blocks available, see [ Adjusting the Preferred DB
    /// Cluster Maintenance
    /// Window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora) in the *Amazon Aurora User Guide*.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `ddd:hh24:mi-ddd:hh24:mi`.
    /// * Days must be one of `Mon | Tue | Wed | Thu | Fri | Sat | Sun`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must be at least 30 minutes.
    preferred_maintenance_window: ?[]const u8 = null,

    /// When you are replicating a DB cluster from one Amazon Web Services GovCloud
    /// (US) Region to another, an URL that contains a Signature Version 4 signed
    /// request for the `CreateDBCluster` operation to be called in the source
    /// Amazon Web Services Region where the DB cluster is replicated from. Specify
    /// `PreSignedUrl` only when you are performing cross-Region replication from an
    /// encrypted DB cluster.
    ///
    /// The presigned URL must be a valid request for the `CreateDBCluster` API
    /// operation that can run in the source Amazon Web Services Region that
    /// contains the encrypted DB cluster to copy.
    ///
    /// The presigned URL request must contain the following parameter values:
    ///
    /// * `KmsKeyId` - The KMS key identifier for the KMS key to use to encrypt the
    ///   copy of the DB cluster in the destination Amazon Web Services Region. This
    ///   should refer to the same KMS key for both the `CreateDBCluster` operation
    ///   that is called in the destination Amazon Web Services Region, and the
    ///   operation contained in the presigned URL.
    /// * `DestinationRegion` - The name of the Amazon Web Services Region that
    ///   Aurora read replica will be created in.
    /// * `ReplicationSourceIdentifier` - The DB cluster identifier for the
    ///   encrypted DB cluster to be copied. This identifier must be in the Amazon
    ///   Resource Name (ARN) format for the source Amazon Web Services Region. For
    ///   example, if you are copying an encrypted DB cluster from the us-west-2
    ///   Amazon Web Services Region, then your `ReplicationSourceIdentifier` would
    ///   look like Example:
    ///   `arn:aws:rds:us-west-2:123456789012:cluster:aurora-cluster1`.
    ///
    /// To learn how to generate a Signature Version 4 signed request, see [
    /// Authenticating Requests: Using Query Parameters (Amazon Web Services
    /// Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) and [ Signature Version 4 Signing Process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    ///
    /// If you are using an Amazon Web Services SDK tool or the CLI, you can specify
    /// `SourceRegion` (or `--source-region` for the CLI) instead of specifying
    /// `PreSignedUrl` manually. Specifying `SourceRegion` autogenerates a presigned
    /// URL that is a valid request for the operation that can run in the source
    /// Amazon Web Services Region.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    pre_signed_url: ?[]const u8 = null,

    /// Specifies whether the DB cluster is publicly accessible.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    ///
    /// When the DB cluster is publicly accessible and you connect from outside of
    /// the DB cluster's virtual private cloud (VPC), its domain name system (DNS)
    /// endpoint resolves to the public IP address. When you connect from within the
    /// same VPC as the DB cluster, the endpoint resolves to the private IP address.
    /// Access to the DB cluster is controlled by its security group settings.
    ///
    /// When the DB cluster isn't publicly accessible, it is an internal DB cluster
    /// with a DNS name that resolves to a private IP address.
    ///
    /// The default behavior when `PubliclyAccessible` is not specified depends on
    /// whether a `DBSubnetGroup` is specified.
    ///
    /// If `DBSubnetGroup` isn't specified, `PubliclyAccessible` defaults to `true`.
    ///
    /// If `DBSubnetGroup` is specified, `PubliclyAccessible` defaults to `false`
    /// unless the value of `DBSubnetGroup` is `default`, in which case
    /// `PubliclyAccessible` defaults to `true`.
    ///
    /// If `PubliclyAccessible` is true and the VPC that the `DBSubnetGroup` is in
    /// doesn't have an internet gateway attached to it, Amazon RDS returns an
    /// error.
    publicly_accessible: ?bool = null,

    /// Reserved for future use.
    rds_custom_cluster_configuration: ?RdsCustomClusterConfiguration = null,

    /// The Amazon Resource Name (ARN) of the source DB instance or DB cluster if
    /// this DB cluster is created as a read replica.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    replication_source_identifier: ?[]const u8 = null,

    /// For DB clusters in `serverless` DB engine mode, the scaling properties of
    /// the DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    scaling_configuration: ?ScalingConfiguration = null,

    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// Specifies whether the DB cluster is encrypted.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    storage_encrypted: ?bool = null,

    /// The storage type to associate with the DB cluster.
    ///
    /// For information on storage types for Aurora DB clusters, see [Storage
    /// configurations for Amazon Aurora DB
    /// clusters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.StorageReliability.html#aurora-storage-type). For information on storage types for Multi-AZ DB clusters, see [Settings for creating Multi-AZ DB clusters](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/create-multi-az-db-cluster.html#create-multi-az-db-cluster-settings).
    ///
    /// This setting is required to create a Multi-AZ DB cluster.
    ///
    /// When specified for a Multi-AZ DB cluster, a value for the `Iops` parameter
    /// is required.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values:
    ///
    /// * Aurora DB clusters - `aurora | aurora-iopt1`
    /// * Multi-AZ DB clusters - `io1 | io2 | gp3`
    ///
    /// Default:
    ///
    /// * Aurora DB clusters - `aurora`
    /// * Multi-AZ DB clusters - `io1`
    ///
    /// When you create an Aurora DB cluster with the storage type set to
    /// `aurora-iopt1`, the storage type is returned in the response. The storage
    /// type isn't returned when you set it to `aurora`.
    storage_type: ?[]const u8 = null,

    /// Tags to assign to the DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    tags: ?[]const Tag = null,

    /// Tags to assign to resources associated with the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * `cluster-auto-backup` - The DB cluster's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// A list of EC2 VPC security groups to associate with this DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateDBClusterOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBClusterInput, options: CallOptions) !CreateDBClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rds");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateDBCluster&Version=2014-10-31");
    if (input.allocated_storage) |v| {
        try body_buf.appendSlice(allocator, "&AllocatedStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.backtrack_window) |v| {
        try body_buf.appendSlice(allocator, "&BacktrackWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&CharacterSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_scalability_type) |v| {
        try body_buf.appendSlice(allocator, "&ClusterScalabilityType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.database_insights_mode) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInsightsMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.database_name) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.db_cluster_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_system_id) |v| {
        try body_buf.appendSlice(allocator, "&DBSystemId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.domain) |v| {
        try body_buf.appendSlice(allocator, "&Domain=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_iam_role_name) |v| {
        try body_buf.appendSlice(allocator, "&DomainIAMRoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.enable_cloudwatch_logs_exports) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EnableCloudwatchLogsExports.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.enable_global_write_forwarding) |v| {
        try body_buf.appendSlice(allocator, "&EnableGlobalWriteForwarding=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_http_endpoint) |v| {
        try body_buf.appendSlice(allocator, "&EnableHttpEndpoint=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_iam_database_authentication) |v| {
        try body_buf.appendSlice(allocator, "&EnableIAMDatabaseAuthentication=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_limitless_database) |v| {
        try body_buf.appendSlice(allocator, "&EnableLimitlessDatabase=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_local_write_forwarding) |v| {
        try body_buf.appendSlice(allocator, "&EnableLocalWriteForwarding=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_performance_insights) |v| {
        try body_buf.appendSlice(allocator, "&EnablePerformanceInsights=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.engine_lifecycle_support) |v| {
        try body_buf.appendSlice(allocator, "&EngineLifecycleSupport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_mode) |v| {
        try body_buf.appendSlice(allocator, "&EngineMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.global_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.master_user_authentication_type) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserAuthenticationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.master_username) |v| {
        try body_buf.appendSlice(allocator, "&MasterUsername=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_secret_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.monitoring_interval) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringInterval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.monitoring_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_group_name) |v| {
        try body_buf.appendSlice(allocator, "&OptionGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.performance_insights_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&PerformanceInsightsKMSKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.performance_insights_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&PerformanceInsightsRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_backup_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredBackupWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.rds_custom_cluster_configuration) |v| {
        if (v.interconnect_subnet_id) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.InterconnectSubnetId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.replica_mode) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.ReplicaMode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.transit_gateway_multicast_domain_id) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.TransitGatewayMulticastDomainId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.replication_source_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ReplicationSourceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.scaling_configuration) |v| {
        if (v.auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.AutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.seconds_before_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.SecondsBeforeTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.SecondsUntilAutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.timeout_action) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.TimeoutAction=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.serverless_v2_scaling_configuration) |v| {
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.SecondsUntilAutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.storage_encrypted) |v| {
        try body_buf.appendSlice(allocator, "&StorageEncrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.storage_type) |v| {
        try body_buf.appendSlice(allocator, "&StorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.VpcSecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBCluster")) {
                    result.db_cluster = try serde.deserializeDBCluster(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupPolicyNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .backup_policy_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlueGreenDeploymentAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .blue_green_deployment_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlueGreenDeploymentNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .blue_green_deployment_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateCustomDBEngineVersionFault")) {
        return .{ .arena = arena, .kind = .{ .create_custom_db_engine_version_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomAvailabilityZoneNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_availability_zone_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterAutomatedBackupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_automated_backup_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterAutomatedBackupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_automated_backup_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterBacktrackNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_backtrack_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterRoleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterRoleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceAutomatedBackupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_automated_backup_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceAutomatedBackupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_automated_backup_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceNotReadyFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_not_ready_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBLogFileNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_log_file_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetAlreadyRegisteredFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_already_registered_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBShardGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_shard_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBShardGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_shard_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSnapshotTenantDatabaseNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_tenant_database_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupNotAllowedFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_not_allowed_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBUpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .db_upgrade_dependency_failure_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .domain_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ec2ImagePropertiesNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .ec_2_image_properties_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventSubscriptionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .event_subscription_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportTaskAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .export_task_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportTaskNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .export_task_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IamRoleMissingPermissionsFault")) {
        return .{ .arena = arena, .kind = .{ .iam_role_missing_permissions_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IamRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .iam_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .instance_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientAvailableIPsInSubnetFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_available_i_ps_in_subnet_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDBClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_db_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDBInstanceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_db_instance_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientStorageClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_storage_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .integration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBlueGreenDeploymentStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_blue_green_deployment_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCustomDBEngineVersionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_custom_db_engine_version_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterAutomatedBackupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_automated_backup_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_endpoint_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBInstanceAutomatedBackupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_instance_automated_backup_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBInstanceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_instance_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBProxyEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_proxy_endpoint_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBProxyStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_proxy_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSecurityGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_security_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBShardGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_shard_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetGroupFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_group_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventSubscriptionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_subscription_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportOnlyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_only_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportSourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_source_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTaskStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_task_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGlobalClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_global_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_option_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxDBShardGroupLimitReached")) {
        return .{ .arena = arena, .kind = .{ .max_db_shard_group_limit_reached = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NetworkTypeNotSupported")) {
        return .{ .arena = arena, .kind = .{ .network_type_not_supported = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptionGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptionGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptionGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRestoreNotEnabledFault")) {
        return .{ .arena = arena, .kind = .{ .point_in_time_restore_not_enabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedIopsNotAvailableInAZFault")) {
        return .{ .arena = arena, .kind = .{ .provisioned_iops_not_available_in_az_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstancesOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instances_offering_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SharedSnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .shared_snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSTopicArnNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .sns_topic_arn_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceClusterNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .source_cluster_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceDatabaseNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .source_database_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .source_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageTypeNotAvailableFault")) {
        return .{ .arena = arena, .kind = .{ .storage_type_not_available_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageTypeNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .storage_type_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionAlreadyExistFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_already_exist_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionCategoryNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_category_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TenantDatabaseAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TenantDatabaseNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TenantDatabaseQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDBEngineVersionFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_db_engine_version_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VpcEncryptionControlViolationException")) {
        return .{ .arena = arena, .kind = .{ .vpc_encryption_control_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
