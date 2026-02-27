const ActivityStreamMode = @import("activity_stream_mode.zig").ActivityStreamMode;
const ActivityStreamPolicyStatus = @import("activity_stream_policy_status.zig").ActivityStreamPolicyStatus;
const ActivityStreamStatus = @import("activity_stream_status.zig").ActivityStreamStatus;
const AdditionalStorageVolumeOutput = @import("additional_storage_volume_output.zig").AdditionalStorageVolumeOutput;
const DBInstanceRole = @import("db_instance_role.zig").DBInstanceRole;
const AutomationMode = @import("automation_mode.zig").AutomationMode;
const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const DBInstanceAutomatedBackupsReplication = @import("db_instance_automated_backups_replication.zig").DBInstanceAutomatedBackupsReplication;
const DBParameterGroupStatus = @import("db_parameter_group_status.zig").DBParameterGroupStatus;
const DBSecurityGroupMembership = @import("db_security_group_membership.zig").DBSecurityGroupMembership;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const DomainMembership = @import("domain_membership.zig").DomainMembership;
const Endpoint = @import("endpoint.zig").Endpoint;
const MasterUserSecret = @import("master_user_secret.zig").MasterUserSecret;
const OptionGroupMembership = @import("option_group_membership.zig").OptionGroupMembership;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const ReplicaMode = @import("replica_mode.zig").ReplicaMode;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const Tag = @import("tag.zig").Tag;
const UpgradeRolloutOrder = @import("upgrade_rollout_order.zig").UpgradeRolloutOrder;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Contains the details of an Amazon RDS DB instance.
///
/// This data type is used as a response element in the operations
/// `CreateDBInstance`, `CreateDBInstanceReadReplica`, `DeleteDBInstance`,
/// `DescribeDBInstances`, `ModifyDBInstance`, `PromoteReadReplica`,
/// `RebootDBInstance`, `RestoreDBInstanceFromDBSnapshot`,
/// `RestoreDBInstanceFromS3`, `RestoreDBInstanceToPointInTime`,
/// `StartDBInstance`, and `StopDBInstance`.
pub const DBInstance = struct {
    /// Indicates whether engine-native audit fields are included in the database
    /// activity stream.
    activity_stream_engine_native_audit_fields_included: ?bool,

    /// The name of the Amazon Kinesis data stream used for the database activity
    /// stream.
    activity_stream_kinesis_stream_name: ?[]const u8,

    /// The Amazon Web Services KMS key identifier used for encrypting messages in
    /// the database activity stream. The Amazon Web Services KMS key identifier is
    /// the key ARN, key ID, alias ARN, or alias name for the KMS key.
    activity_stream_kms_key_id: ?[]const u8,

    /// The mode of the database activity stream. Database events such as a change
    /// or access generate an activity stream event. RDS for Oracle always handles
    /// these events asynchronously.
    activity_stream_mode: ?ActivityStreamMode,

    /// The status of the policy state of the activity stream.
    activity_stream_policy_status: ?ActivityStreamPolicyStatus,

    /// The status of the database activity stream.
    activity_stream_status: ?ActivityStreamStatus,

    /// The additional storage volumes associated with the DB instance. RDS supports
    /// additional storage volumes for RDS for Oracle and RDS for SQL Server.
    additional_storage_volumes: ?[]const AdditionalStorageVolumeOutput,

    /// The amount of storage in gibibytes (GiB) allocated for the DB instance.
    allocated_storage: ?i32,

    /// The Amazon Web Services Identity and Access Management (IAM) roles
    /// associated with the DB instance.
    associated_roles: ?[]const DBInstanceRole,

    /// The time when a stopped DB instance is restarted automatically.
    automatic_restart_time: ?i64,

    /// The automation mode of the RDS Custom DB instance: `full` or `all paused`.
    /// If `full`, the DB instance automates monitoring and instance recovery. If
    /// `all paused`, the instance pauses automation for the duration set by
    /// `--resume-full-automation-mode-minutes`.
    automation_mode: ?AutomationMode,

    /// Indicates whether minor version patches are applied automatically.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool,

    /// The name of the Availability Zone where the DB instance is located.
    availability_zone: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    aws_backup_recovery_point_arn: ?[]const u8,

    /// The number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32,

    /// The location where automated backups and manual snapshots are stored:
    /// Dedicated Local Zones, Amazon Web Services Outposts or the Amazon Web
    /// Services Region.
    backup_target: ?[]const u8,

    /// The identifier of the CA certificate for this DB instance.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    ca_certificate_identifier: ?[]const u8,

    /// The details of the DB instance's server certificate.
    certificate_details: ?CertificateDetails,

    /// If present, specifies the name of the character set that this instance is
    /// associated with.
    character_set_name: ?[]const u8,

    /// Indicates whether tags are copied from the DB instance to snapshots of the
    /// DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Copying tags to
    /// snapshots is managed by the DB cluster. Setting this value for an Aurora DB
    /// instance has no effect on the DB cluster setting. For more information, see
    /// `DBCluster`.
    copy_tags_to_snapshot: ?bool,

    /// Indicates whether a customer-owned IP address (CoIP) is enabled for an RDS
    /// on Outposts DB instance.
    ///
    /// A *CoIP *provides local or external connectivity to resources in your
    /// Outpost subnets through your on-premises network. For some use cases, a CoIP
    /// can provide lower latency for connections to the DB instance from outside of
    /// its virtual private cloud (VPC) on your local network.
    ///
    /// For more information about RDS on Outposts, see [Working with Amazon RDS on
    /// Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide*.
    ///
    /// For more information about CoIPs, see [Customer-owned IP
    /// addresses](https://docs.aws.amazon.com/outposts/latest/userguide/routing.html#ip-addressing) in the *Amazon Web Services Outposts User Guide*.
    customer_owned_ip_enabled: ?bool,

    /// The instance profile associated with the underlying Amazon EC2 instance of
    /// an RDS Custom DB instance. The instance profile must meet the following
    /// requirements:
    ///
    /// * The profile must exist in your account.
    /// * The profile must have an IAM role that Amazon EC2 has permissions to
    ///   assume.
    /// * The instance profile name and the associated IAM role name must start with
    ///   the prefix `AWSRDSCustom`.
    ///
    /// For the list of permissions required for the IAM role, see [ Configure IAM
    /// and your
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc) in the *Amazon RDS User Guide*.
    custom_iam_instance_profile: ?[]const u8,

    /// The mode of Database Insights that is enabled for the instance.
    database_insights_mode: ?DatabaseInsightsMode,

    /// If the DB instance is a member of a DB cluster, indicates the name of the DB
    /// cluster that the DB instance is a member of.
    db_cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the DB instance.
    db_instance_arn: ?[]const u8,

    /// The list of replicated automated backups associated with the DB instance.
    db_instance_automated_backups_replications: ?[]const DBInstanceAutomatedBackupsReplication,

    /// The name of the compute and memory capacity class of the DB instance.
    db_instance_class: ?[]const u8,

    /// The user-supplied database identifier. This identifier is the unique key
    /// that identifies a DB instance.
    db_instance_identifier: ?[]const u8,

    /// The port that the DB instance listens on. If the DB instance is part of a DB
    /// cluster, this can be a different port than the DB cluster port.
    db_instance_port: ?i32,

    /// The current state of this database.
    ///
    /// For information about DB instance statuses, see [Viewing DB instance
    /// status](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/accessing-monitoring.html#Overview.DBInstance.Status) in the *Amazon RDS User Guide.*
    db_instance_status: ?[]const u8,

    /// The Amazon Web Services Region-unique, immutable identifier for the DB
    /// instance. This identifier is found in Amazon Web Services CloudTrail log
    /// entries whenever the Amazon Web Services KMS key for the DB instance is
    /// accessed.
    dbi_resource_id: ?[]const u8,

    /// The initial database name that you provided (if required) when you created
    /// the DB instance. This name is returned for the life of your DB instance. For
    /// an RDS for Oracle CDB instance, the name identifies the PDB rather than the
    /// CDB.
    db_name: ?[]const u8,

    /// The list of DB parameter groups applied to this DB instance.
    db_parameter_groups: ?[]const DBParameterGroupStatus,

    /// A list of DB security group elements containing `DBSecurityGroup.Name` and
    /// `DBSecurityGroup.Status` subelements.
    db_security_groups: ?[]const DBSecurityGroupMembership,

    /// Information about the subnet group associated with the DB instance,
    /// including the name, description, and subnets in the subnet group.
    db_subnet_group: ?DBSubnetGroup,

    /// The Oracle system ID (Oracle SID) for a container database (CDB). The Oracle
    /// SID is also the name of the CDB. This setting is only valid for RDS Custom
    /// DB instances.
    db_system_id: ?[]const u8,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool,

    /// Indicates whether the DB instance has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled. For more
    /// information, see [ Deleting a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).
    deletion_protection: ?bool,

    /// The Active Directory Domain membership records associated with the DB
    /// instance.
    domain_memberships: ?[]const DomainMembership,

    /// A list of log types that this DB instance is configured to export to
    /// CloudWatch Logs.
    ///
    /// Log types vary by DB engine. For information about the log types for each DB
    /// engine, see [Monitoring Amazon RDS log
    /// files](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html) in the *Amazon RDS User Guide.*
    enabled_cloudwatch_logs_exports: ?[]const []const u8,

    /// The connection endpoint for the DB instance.
    ///
    /// The endpoint might not be shown for instances with the status of `creating`.
    endpoint: ?Endpoint,

    /// The database engine used for this DB instance.
    engine: ?[]const u8,

    /// The lifecycle type for the DB instance.
    ///
    /// For more information, see CreateDBInstance.
    engine_lifecycle_support: ?[]const u8,

    /// The version of the database engine.
    engine_version: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log stream that
    /// receives the Enhanced Monitoring metrics data for the DB instance.
    enhanced_monitoring_resource_arn: ?[]const u8,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled for the DB
    /// instance.
    ///
    /// For a list of engine versions that support IAM database authentication, see
    /// [IAM database
    /// authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RDS_Fea_Regions_DB-eng.Feature.IamDatabaseAuthentication.html) in the *Amazon RDS User Guide* and [IAM database authentication in Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.Aurora_Fea_Regions_DB-eng.Feature.IAMdbauth.html) in the *Amazon Aurora User Guide*.
    iam_database_authentication_enabled: ?bool,

    /// The date and time when the DB instance was created.
    instance_create_time: ?i64,

    /// The Provisioned IOPS (I/O operations per second) value for the DB instance.
    iops: ?i32,

    /// Indicates whether an upgrade is recommended for the storage file system
    /// configuration on the DB instance. To migrate to the preferred configuration,
    /// you can either create a blue/green deployment, or create a read replica from
    /// the DB instance. For more information, see [Upgrading the storage file
    /// system for a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.UpgradeFileSystem).
    is_storage_config_upgrade_available: ?bool,

    /// If `StorageEncrypted` is enabled, the Amazon Web Services KMS key identifier
    /// for the encrypted DB instance.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8,

    /// The latest time to which a database in this DB instance can be restored with
    /// point-in-time restore.
    latest_restorable_time: ?i64,

    /// The license model information for this DB instance. This setting doesn't
    /// apply to Amazon Aurora or RDS Custom DB instances.
    license_model: ?[]const u8,

    /// The listener connection endpoint for SQL Server Always On.
    listener_endpoint: ?Endpoint,

    /// The master username for the DB instance.
    master_username: ?[]const u8,

    /// The secret managed by RDS in Amazon Web Services Secrets Manager for the
    /// master user password.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    master_user_secret: ?MasterUserSecret,

    /// The upper limit in gibibytes (GiB) to which Amazon RDS can automatically
    /// scale the storage of the DB instance.
    max_allocated_storage: ?i32,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB instance.
    monitoring_interval: ?i32,

    /// The ARN for the IAM role that permits RDS to send Enhanced Monitoring
    /// metrics to Amazon CloudWatch Logs.
    monitoring_role_arn: ?[]const u8,

    /// Indicates whether the DB instance is a Multi-AZ deployment. This setting
    /// doesn't apply to RDS Custom DB instances.
    multi_az: ?bool,

    /// Specifies whether the DB instance is in the multi-tenant configuration
    /// (TRUE) or the single-tenant configuration (FALSE).
    multi_tenant: ?bool,

    /// The name of the NCHAR character set for the Oracle DB instance. This
    /// character set specifies the Unicode encoding for data stored in table
    /// columns of type NCHAR, NCLOB, or NVARCHAR2.
    nchar_character_set_name: ?[]const u8,

    /// The network type of the DB instance.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the DB
    /// instance. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide* and [ Working with a DB instance in a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid Values: `IPV4 | DUAL`
    network_type: ?[]const u8,

    /// The list of option group memberships for this DB instance.
    option_group_memberships: ?[]const OptionGroupMembership,

    /// Information about pending changes to the DB instance. This information is
    /// returned only when there are pending changes. Specific changes are
    /// identified by subelements.
    pending_modified_values: ?PendingModifiedValues,

    /// The progress of the storage optimization operation as a percentage.
    percent_progress: ?[]const u8,

    /// Indicates whether Performance Insights is enabled for the DB instance.
    performance_insights_enabled: ?bool,

    /// The Amazon Web Services KMS key identifier for encryption of Performance
    /// Insights data.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    performance_insights_kms_key_id: ?[]const u8,

    /// The number of days to retain Performance Insights data.
    ///
    /// Valid Values:
    ///
    /// * `7`
    /// * *month* * 31, where *month* is a number of months from 1-23. Examples:
    ///   `93` (3 months * 31), `341` (11 months * 31), `589` (19 months * 31)
    /// * `731`
    ///
    /// Default: `7` days
    performance_insights_retention_period: ?i32,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance.
    processor_features: ?[]const ProcessorFeature,

    /// The order of priority in which an Aurora Replica is promoted to the primary
    /// instance after a failure of the existing primary instance. For more
    /// information, see [ Fault Tolerance for an Aurora DB
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html#Aurora.Managing.FaultTolerance) in the *Amazon Aurora User Guide*.
    promotion_tier: ?i32,

    /// Indicates whether the DB instance is publicly accessible.
    ///
    /// When the DB instance is publicly accessible and you connect from outside of
    /// the DB instance's virtual private cloud (VPC), its Domain Name System (DNS)
    /// endpoint resolves to the public IP address. When you connect from within the
    /// same VPC as the DB instance, the endpoint resolves to the private IP
    /// address. Access to the DB cluster is ultimately controlled by the security
    /// group it uses. That public access isn't permitted if the security group
    /// assigned to the DB cluster doesn't permit it.
    ///
    /// When the DB instance isn't publicly accessible, it is an internal DB
    /// instance with a DNS name that resolves to a private IP address.
    ///
    /// For more information, see CreateDBInstance.
    publicly_accessible: ?bool,

    /// The identifiers of Aurora DB clusters to which the RDS DB instance is
    /// replicated as a read replica. For example, when you create an Aurora read
    /// replica of an RDS for MySQL DB instance, the Aurora MySQL DB cluster for the
    /// Aurora read replica is shown. This output doesn't contain information about
    /// cross-Region Aurora read replicas.
    ///
    /// Currently, each RDS DB instance can have only one Aurora read replica.
    read_replica_db_cluster_identifiers: ?[]const []const u8,

    /// The identifiers of the read replicas associated with this DB instance.
    read_replica_db_instance_identifiers: ?[]const []const u8,

    /// The identifier of the source DB cluster if this DB instance is a read
    /// replica.
    read_replica_source_db_cluster_identifier: ?[]const u8,

    /// The identifier of the source DB instance if this DB instance is a read
    /// replica.
    read_replica_source_db_instance_identifier: ?[]const u8,

    /// The open mode of a Db2 or an Oracle read replica. The default is
    /// `open-read-only`. For more information, see [Working with replicas for
    /// Amazon RDS for
    /// Db2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-replication.html) and [Working with read replicas for Amazon RDS for Oracle](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.html) in the *Amazon RDS User Guide*.
    ///
    /// This attribute is only supported in RDS for Db2, RDS for Oracle, and RDS
    /// Custom for Oracle.
    replica_mode: ?ReplicaMode,

    /// The number of minutes to pause the automation. When the time period ends,
    /// RDS Custom resumes full automation. The minimum value is 60 (default). The
    /// maximum value is 1,440.
    resume_full_automation_mode_time: ?i64,

    /// If present, specifies the name of the secondary Availability Zone for a DB
    /// instance with multi-AZ support.
    secondary_availability_zone: ?[]const u8,

    /// The status of a read replica. If the DB instance isn't a read replica, the
    /// value is blank.
    status_infos: ?[]const DBInstanceStatusInfo,

    /// Indicates whether the DB instance is encrypted.
    storage_encrypted: ?bool,

    /// The storage throughput for the DB instance.
    ///
    /// This setting applies only to the `gp3` storage type.
    storage_throughput: ?i32,

    /// The storage type associated with the DB instance.
    storage_type: ?[]const u8,

    /// The detailed status information for storage volumes associated with the DB
    /// instance. This information helps identify which specific volume is causing
    /// the instance to be in a storage-full state.
    storage_volume_status: ?[]const u8,

    tag_list: ?[]const Tag,

    /// The ARN from the key store with which the instance is associated for TDE
    /// encryption.
    tde_credential_arn: ?[]const u8,

    /// The time zone of the DB instance. In most cases, the `Timezone` element is
    /// empty. `Timezone` content appears only for RDS for Db2 and RDS for SQL
    /// Server DB instances that were created with a time zone specified.
    timezone: ?[]const u8,

    /// This data type represents the order in which the instances are upgraded.
    ///
    /// * [first] - Typically used for development or testing environments.
    /// * [second] - Default order for resources not specifically configured.
    /// * [last] - Usually reserved for production environments.
    upgrade_rollout_order: ?UpgradeRolloutOrder,

    /// The list of Amazon EC2 VPC security groups that the DB instance belongs to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership,
};
