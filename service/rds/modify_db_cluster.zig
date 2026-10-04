const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const MasterUserAuthenticationType = @import("master_user_authentication_type.zig").MasterUserAuthenticationType;
const ScalingConfiguration = @import("scaling_configuration.zig").ScalingConfiguration;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const ModifyDBClusterInput = struct {
    /// The amount of storage in gibibytes (GiB) to allocate to each DB instance in
    /// the Multi-AZ DB cluster.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    allocated_storage: ?i32 = null,

    /// Specifies whether engine mode changes from `serverless` to `provisioned` are
    /// allowed.
    ///
    /// Valid for Cluster Type: Aurora Serverless v1 DB clusters only
    ///
    /// Constraints:
    ///
    /// * You must allow engine mode changes when specifying a different value for
    ///   the `EngineMode` parameter from the DB cluster's current engine mode.
    allow_engine_mode_change: ?bool = null,

    /// Specifies whether major version upgrades are allowed.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * You must allow major version upgrades when specifying a value for the
    ///   `EngineVersion` parameter that is a different major version than the DB
    ///   cluster's current version.
    allow_major_version_upgrade: ?bool = null,

    /// Specifies whether the modifications in this request are asynchronously
    /// applied as soon as possible, regardless of the `PreferredMaintenanceWindow`
    /// setting for the DB cluster. If this parameter is disabled, changes to the DB
    /// cluster are applied during the next maintenance window.
    ///
    /// Most modifications can be applied immediately or during the next scheduled
    /// maintenance window. Some modifications, such as turning on deletion
    /// protection and changing the master password, are applied
    /// immediately—regardless of when you choose to apply them.
    ///
    /// By default, this parameter is disabled.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    apply_immediately: ?bool = null,

    /// Specifies whether minor engine upgrades are applied automatically to the DB
    /// cluster during the maintenance window. By default, minor engine upgrades are
    /// applied automatically.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    aws_backup_recovery_point_arn: ?[]const u8 = null,

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

    /// The number of days for which automated backups are retained. Specify a
    /// minimum value of `1`.
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

    /// The configuration setting for the log types to be enabled for export to
    /// CloudWatch Logs for a specific DB cluster.
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
    /// For more information about exporting CloudWatch Logs for Amazon RDS, see [
    /// Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// For more information about exporting CloudWatch Logs for Amazon Aurora, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Aurora User Guide*.
    cloudwatch_logs_export_configuration: ?CloudwatchLogsExportConfiguration = null,

    /// Specifies whether to copy all tags from the DB cluster to snapshots of the
    /// DB cluster. The default is not to copy them.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    copy_tags_to_snapshot: ?bool = null,

    /// Specifies the mode of Database Insights to enable for the DB cluster.
    ///
    /// If you change the value from `standard` to `advanced`, you must set the
    /// `PerformanceInsightsEnabled` parameter to `true` and the
    /// `PerformanceInsightsRetentionPeriod` parameter to 465.
    ///
    /// If you change the value from `advanced` to `standard`, you can set the
    /// `PerformanceInsightsEnabled` parameter to `true` to collect detailed
    /// database counter and per-query metrics.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The DB cluster identifier for the cluster being modified. This parameter
    /// isn't case-sensitive.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DB cluster.
    db_cluster_identifier: []const u8,

    /// The compute and memory capacity of each DB instance in the Multi-AZ DB
    /// cluster, for example `db.m6gd.xlarge`. Not all DB instance classes are
    /// available in all Amazon Web Services Regions, or for all database engines.
    ///
    /// For the full list of DB instance classes and availability for your engine,
    /// see [ DB Instance
    /// Class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    db_cluster_instance_class: ?[]const u8 = null,

    /// The name of the DB cluster parameter group to use for the DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// The name of the DB parameter group to apply to all instances of the DB
    /// cluster.
    ///
    /// When you apply a parameter group using the `DBInstanceParameterGroupName`
    /// parameter, the DB cluster isn't rebooted automatically. Also, parameter
    /// changes are applied immediately rather than during the next maintenance
    /// window.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    ///
    /// Default: The existing name setting
    ///
    /// Constraints:
    ///
    /// * The DB parameter group must be in the same DB parameter group family as
    ///   this DB cluster.
    /// * The `DBInstanceParameterGroupName` parameter is valid in combination with
    ///   the `AllowMajorVersionUpgrade` parameter for a major version upgrade only.
    db_instance_parameter_group_name: ?[]const u8 = null,

    /// Specifies whether the DB cluster has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    deletion_protection: ?bool = null,

    /// The Active Directory directory ID to move the DB cluster to. Specify `none`
    /// to remove the cluster from its current domain. The domain must be created
    /// prior to this operation.
    ///
    /// For more information, see [Kerberos
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/kerberos-authentication.html) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    domain: ?[]const u8 = null,

    /// The name of the IAM role to use when making API calls to the Directory
    /// Service.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    domain_iam_role_name: ?[]const u8 = null,

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

    /// Specifies whether to enable the HTTP endpoint for an Aurora Serverless v1 DB
    /// cluster. By default, the HTTP endpoint isn't enabled.
    ///
    /// When enabled, the HTTP endpoint provides a connectionless web service API
    /// (RDS Data API) for running SQL queries on the Aurora Serverless v1 DB
    /// cluster. You can also query your database from inside the RDS console with
    /// the RDS query editor.
    ///
    /// For more information, see [Using RDS Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    ///
    /// This parameter applies only to Aurora Serverless v1 DB clusters. To enable
    /// or disable the HTTP endpoint for an Aurora Serverless v2 or provisioned DB
    /// cluster, use the `EnableHttpEndpoint` and `DisableHttpEndpoint` operations.
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
    /// setting when you create your Aurora Limitless Database DB cluster.
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

    /// The DB engine mode of the DB cluster, either `provisioned` or `serverless`.
    ///
    /// The DB engine mode can be modified only from `serverless` to `provisioned`.
    ///
    /// For more information, see [
    /// CreateDBCluster](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBCluster.html).
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    engine_mode: ?[]const u8 = null,

    /// The version number of the database engine to which you want to upgrade.
    /// Changing this parameter results in an outage. The change is applied during
    /// the next maintenance window unless `ApplyImmediately` is enabled.
    ///
    /// If the cluster that you're modifying has one or more read replicas, all
    /// replicas must be running an engine version that's the same or later than the
    /// version you specify.
    ///
    /// To list all of the available engine versions for Aurora MySQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-mysql --query
    /// "DBEngineVersions[].EngineVersion"`
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
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    engine_version: ?[]const u8 = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to be
    /// initially allocated for each DB instance in the Multi-AZ DB cluster.
    ///
    /// For information about valid IOPS values, see [Amazon RDS Provisioned IOPS
    /// storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the *Amazon RDS User Guide*.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    ///
    /// Constraints:
    ///
    /// * Must be a multiple between .5 and 50 of the storage amount for the DB
    ///   cluster.
    iops: ?i32 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// If the DB cluster doesn't manage the master user password with Amazon Web
    /// Services Secrets Manager, you can turn on this management. In this case, you
    /// can't specify `MasterUserPassword`.
    ///
    /// If the DB cluster already manages the master user password with Amazon Web
    /// Services Secrets Manager, and you specify that the master user password is
    /// not managed with Amazon Web Services Secrets Manager, then you must specify
    /// `MasterUserPassword`. In this case, RDS deletes the secret and uses the new
    /// password for the master user specified by `MasterUserPassword`.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    manage_master_user_password: ?bool = null,

    /// Specifies the authentication type for the master user. With IAM master user
    /// authentication, you can change the master DB user to use IAM database
    /// authentication.
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

    /// The new password for the master database user.
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
    /// This setting is valid only if both of the following conditions are met:
    ///
    /// * The DB cluster doesn't manage the master user password in Amazon Web
    ///   Services Secrets Manager.
    ///
    /// If the DB cluster already manages the master user password in Amazon Web
    /// Services Secrets Manager, you can't change the KMS key that is used to
    /// encrypt the secret.
    /// * You are turning on `ManageMasterUserPassword` to manage the master user
    ///   password in Amazon Web Services Secrets Manager.
    ///
    /// If you are turning on `ManageMasterUserPassword` and don't specify
    /// `MasterUserSecretKmsKeyId`, then the `aws/secretsmanager` KMS key is used to
    /// encrypt the secret. If the secret is in a different Amazon Web Services
    /// account, then you can't use the `aws/secretsmanager` KMS key to encrypt the
    /// secret, and you must use a customer managed KMS key.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
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
    /// Valid for Cluster Type: Multi-AZ DB clusters only
    ///
    /// Valid Values: `0 | 1 | 5 | 10 | 15 | 30 | 60`
    ///
    /// Default: `0`
    monitoring_interval: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the IAM role that permits RDS to send
    /// Enhanced Monitoring metrics to Amazon CloudWatch Logs. An example is
    /// `arn:aws:iam:123456789012:role/emaccess`. For information on creating a
    /// monitoring role, see [To create an IAM role for Amazon RDS Enhanced
    /// Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html#USER_Monitoring.OS.IAMRole) in the *Amazon RDS User Guide.*
    ///
    /// If `MonitoringInterval` is set to a value other than `0`, supply a
    /// `MonitoringRoleArn` value.
    ///
    /// Valid for Cluster Type: Multi-AZ DB clusters only
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

    /// The new DB cluster identifier for the DB cluster when renaming a DB cluster.
    /// This value is stored as a lowercase string.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * The first character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster2`
    new_db_cluster_identifier: ?[]const u8 = null,

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

    /// The port number on which the DB cluster accepts connections.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    ///
    /// Valid Values: `1150-65535`
    ///
    /// Default: The same port as the original DB cluster.
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, using the `BackupRetentionPeriod` parameter.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region. To view the time blocks available,
    /// see [ Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.Backups.BackupWindow) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated Time (UTC).
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

    /// Specifies whether to rotate the secret managed by Amazon Web Services
    /// Secrets Manager for the master user password.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB cluster. The secret value
    /// contains the updated password.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * You must apply the change immediately when rotating the master user
    ///   password.
    rotate_master_user_password: ?bool = null,

    /// The scaling properties of the DB cluster. You can only modify scaling
    /// properties for DB clusters in `serverless` DB engine mode.
    ///
    /// Valid for Cluster Type: Aurora DB clusters only
    scaling_configuration: ?ScalingConfiguration = null,

    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The storage type to associate with the DB cluster.
    ///
    /// For information on storage types for Aurora DB clusters, see [Storage
    /// configurations for Amazon Aurora DB
    /// clusters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.StorageReliability.html#aurora-storage-type). For information on storage types for Multi-AZ DB clusters, see [Settings for creating Multi-AZ DB clusters](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/create-multi-az-db-cluster.html#create-multi-az-db-cluster-settings).
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
    storage_type: ?[]const u8 = null,

    /// A list of EC2 VPC security groups to associate with this DB cluster.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyDBClusterOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBClusterInput, options: CallOptions) !ModifyDBClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBCluster&Version=2014-10-31");
    if (input.allocated_storage) |v| {
        try body_buf.appendSlice(allocator, "&AllocatedStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.allow_engine_mode_change) |v| {
        try body_buf.appendSlice(allocator, "&AllowEngineModeChange=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.allow_major_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowMajorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.aws_backup_recovery_point_arn) |v| {
        try body_buf.appendSlice(allocator, "&AwsBackupRecoveryPointArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    if (input.cloudwatch_logs_export_configuration) |v| {
        if (v.disable_log_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CloudwatchLogsExportConfiguration.DisableLogTypes.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.enable_log_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CloudwatchLogsExportConfiguration.EnableLogTypes.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.database_insights_mode) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInsightsMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.db_instance_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceParameterGroupName=");
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
    if (input.engine_mode) |v| {
        try body_buf.appendSlice(allocator, "&EngineMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.master_user_authentication_type) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserAuthenticationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.new_db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewDBClusterIdentifier=");
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
    if (input.rotate_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&RotateMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.storage_type) |v| {
        try body_buf.appendSlice(allocator, "&StorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBClusterOutput = .{};
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
