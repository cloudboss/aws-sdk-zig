const AwsRdsDbInstanceAssociatedRole = @import("aws_rds_db_instance_associated_role.zig").AwsRdsDbInstanceAssociatedRole;
const AwsRdsDbParameterGroup = @import("aws_rds_db_parameter_group.zig").AwsRdsDbParameterGroup;
const AwsRdsDbSubnetGroup = @import("aws_rds_db_subnet_group.zig").AwsRdsDbSubnetGroup;
const AwsRdsDbDomainMembership = @import("aws_rds_db_domain_membership.zig").AwsRdsDbDomainMembership;
const AwsRdsDbInstanceEndpoint = @import("aws_rds_db_instance_endpoint.zig").AwsRdsDbInstanceEndpoint;
const AwsRdsDbOptionGroupMembership = @import("aws_rds_db_option_group_membership.zig").AwsRdsDbOptionGroupMembership;
const AwsRdsDbPendingModifiedValues = @import("aws_rds_db_pending_modified_values.zig").AwsRdsDbPendingModifiedValues;
const AwsRdsDbProcessorFeature = @import("aws_rds_db_processor_feature.zig").AwsRdsDbProcessorFeature;
const AwsRdsDbStatusInfo = @import("aws_rds_db_status_info.zig").AwsRdsDbStatusInfo;
const AwsRdsDbInstanceVpcSecurityGroup = @import("aws_rds_db_instance_vpc_security_group.zig").AwsRdsDbInstanceVpcSecurityGroup;

/// Contains the details of an Amazon RDS DB instance.
pub const AwsRdsDbInstanceDetails = struct {
    /// The amount of storage (in gigabytes) to initially allocate for the DB
    /// instance.
    allocated_storage: ?i32 = null,

    /// The IAM roles associated with the DB
    /// instance.
    associated_roles: ?[]const AwsRdsDbInstanceAssociatedRole = null,

    /// Indicates whether minor version patches are applied automatically.
    auto_minor_version_upgrade: ?bool = null,

    /// The Availability Zone where the DB instance will be created.
    availability_zone: ?[]const u8 = null,

    /// The number of days for which to retain automated backups.
    backup_retention_period: ?i32 = null,

    /// The identifier of the CA certificate for this DB instance.
    ca_certificate_identifier: ?[]const u8 = null,

    /// The name of the character set that this DB instance is associated with.
    character_set_name: ?[]const u8 = null,

    /// Whether to copy resource tags to snapshots of the DB instance.
    copy_tags_to_snapshot: ?bool = null,

    /// If the DB instance is a member of a DB cluster, contains the name of the DB
    /// cluster that
    /// the DB instance is a member of.
    db_cluster_identifier: ?[]const u8 = null,

    /// Contains the name of the compute and memory capacity class of the DB
    /// instance.
    db_instance_class: ?[]const u8 = null,

    /// Contains a user-supplied database identifier. This identifier is the unique
    /// key that
    /// identifies a DB instance.
    db_instance_identifier: ?[]const u8 = null,

    /// Specifies the port that the DB instance listens on. If the DB instance is
    /// part of a DB
    /// cluster, this can be a different port than the DB cluster port.
    db_instance_port: ?i32 = null,

    /// The current status of the DB instance.
    db_instance_status: ?[]const u8 = null,

    /// The Amazon Web Services Region-unique, immutable identifier for the DB
    /// instance. This identifier is
    /// found in CloudTrail log entries whenever the KMS key for the DB instance is
    /// accessed.
    dbi_resource_id: ?[]const u8 = null,

    /// The meaning of this parameter differs according to the database engine you
    /// use.
    ///
    /// **MySQL, MariaDB, SQL Server, PostgreSQL**
    ///
    /// Contains the name of the initial database of this instance that was provided
    /// at create
    /// time, if one was specified when the DB instance was created. This same name
    /// is returned for
    /// the life of the DB instance.
    ///
    /// **Oracle**
    ///
    /// Contains the Oracle System ID (SID) of the created DB instance. Not shown
    /// when the
    /// returned parameters don't apply to an Oracle DB instance.
    db_name: ?[]const u8 = null,

    /// A list of the DB parameter groups to assign to the DB instance.
    db_parameter_groups: ?[]const AwsRdsDbParameterGroup = null,

    /// A list of the DB security groups to assign to the DB instance.
    db_security_groups: ?[]const []const u8 = null,

    /// Information about the subnet group that is associated with the DB instance.
    db_subnet_group: ?AwsRdsDbSubnetGroup = null,

    /// Indicates whether the DB instance has deletion protection enabled.
    ///
    /// When deletion protection is enabled, the database cannot be deleted.
    deletion_protection: ?bool = null,

    /// The Active Directory domain membership records associated with the DB
    /// instance.
    domain_memberships: ?[]const AwsRdsDbDomainMembership = null,

    /// A list of log types that this DB instance is configured to export to
    /// CloudWatch Logs.
    enabled_cloud_watch_logs_exports: ?[]const []const u8 = null,

    /// Specifies the connection endpoint.
    endpoint: ?AwsRdsDbInstanceEndpoint = null,

    /// Provides the name of the database engine to use for this DB instance.
    engine: ?[]const u8 = null,

    /// Indicates the database engine version.
    engine_version: ?[]const u8 = null,

    /// The ARN of the CloudWatch Logs log stream that receives the enhanced
    /// monitoring metrics
    /// data for the DB instance.
    enhanced_monitoring_resource_arn: ?[]const u8 = null,

    /// True if mapping of IAM accounts to database
    /// accounts is enabled, and otherwise false.
    ///
    /// IAM database authentication can be enabled for the following database
    /// engines.
    ///
    /// * For MySQL 5.6, minor version 5.6.34 or higher
    ///
    /// * For MySQL 5.7, minor version 5.7.16 or higher
    ///
    /// * Aurora 5.6 or higher
    iam_database_authentication_enabled: ?bool = null,

    /// Indicates when the DB instance was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    instance_create_time: ?[]const u8 = null,

    /// Specifies the provisioned IOPS (I/O operations per second) for this DB
    /// instance.
    iops: ?i32 = null,

    /// If `StorageEncrypted` is true, the KMS key identifier for the encrypted
    /// DB instance.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the latest time to which a database can be restored with
    /// point-in-time
    /// restore.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    latest_restorable_time: ?[]const u8 = null,

    /// License model information for this DB instance.
    license_model: ?[]const u8 = null,

    listener_endpoint: ?AwsRdsDbInstanceEndpoint = null,

    /// The master user name of the DB instance.
    master_username: ?[]const u8 = null,

    /// The upper limit to which Amazon RDS can automatically scale the storage of
    /// the DB
    /// instance.
    max_allocated_storage: ?i32 = null,

    /// The interval, in seconds, between points when enhanced monitoring metrics
    /// are collected
    /// for the DB instance.
    monitoring_interval: ?i32 = null,

    /// The ARN for the IAM role that permits Amazon RDS to send enhanced monitoring
    /// metrics to
    /// CloudWatch Logs.
    monitoring_role_arn: ?[]const u8 = null,

    /// Whether the DB instance is a multiple Availability Zone deployment.
    multi_az: ?bool = null,

    /// The list of option group memberships for this DB instance.
    option_group_memberships: ?[]const AwsRdsDbOptionGroupMembership = null,

    /// Changes to the DB instance that are currently pending.
    pending_modified_values: ?AwsRdsDbPendingModifiedValues = null,

    /// Indicates whether Performance Insights is enabled for the DB instance.
    performance_insights_enabled: ?bool = null,

    /// The identifier of the KMS key used to encrypt the Performance Insights data.
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The number of days to retain Performance Insights data.
    performance_insights_retention_period: ?i32 = null,

    /// The range of time each day when automated backups are created, if automated
    /// backups are
    /// enabled.
    ///
    /// Uses the format `HH:MM-HH:MM`. For example, `04:52-05:22`.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal
    /// Coordinated Time (UTC).
    ///
    /// Uses the format `:HH:MM-:HH:MM`.
    ///
    /// For the day values, use
    /// `mon`|`tue`|`wed`|`thu`|`fri`|`sat`|`sun`.
    ///
    /// For example, `sun:09:32-sun:10:02`.
    preferred_maintenance_window: ?[]const u8 = null,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of
    /// the DB instance.
    processor_features: ?[]const AwsRdsDbProcessorFeature = null,

    /// The order in which to promote an Aurora replica to the primary instance
    /// after a failure
    /// of the existing primary instance.
    promotion_tier: ?i32 = null,

    /// Specifies the accessibility options for the DB instance.
    ///
    /// A value of true specifies an Internet-facing instance with a publicly
    /// resolvable DNS
    /// name, which resolves to a public IP address.
    ///
    /// A value of false specifies an internal instance with a DNS name that
    /// resolves to a
    /// private IP address.
    publicly_accessible: ?bool = null,

    /// List of identifiers of Aurora DB clusters to which the RDS DB instance is
    /// replicated as
    /// a read replica.
    read_replica_db_cluster_identifiers: ?[]const []const u8 = null,

    /// List of identifiers of the read replicas associated with this DB instance.
    read_replica_db_instance_identifiers: ?[]const []const u8 = null,

    /// If this DB instance is a read replica, contains the identifier of the source
    /// DB
    /// instance.
    read_replica_source_db_instance_identifier: ?[]const u8 = null,

    /// For a DB instance with multi-Availability Zone support, the name of the
    /// secondary
    /// Availability Zone.
    secondary_availability_zone: ?[]const u8 = null,

    /// The status of a read replica. If the instance isn't a read replica, this is
    /// empty.
    status_infos: ?[]const AwsRdsDbStatusInfo = null,

    /// Specifies whether the DB instance is encrypted.
    storage_encrypted: ?bool = null,

    /// The storage type for the DB instance.
    storage_type: ?[]const u8 = null,

    /// The ARN from the key store with which the instance is associated for TDE
    /// encryption.
    tde_credential_arn: ?[]const u8 = null,

    /// The time zone of the DB instance.
    timezone: ?[]const u8 = null,

    /// A list of VPC security groups that the DB instance belongs to.
    vpc_security_groups: ?[]const AwsRdsDbInstanceVpcSecurityGroup = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .associated_roles = "AssociatedRoles",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zone = "AvailabilityZone",
        .backup_retention_period = "BackupRetentionPeriod",
        .ca_certificate_identifier = "CACertificateIdentifier",
        .character_set_name = "CharacterSetName",
        .copy_tags_to_snapshot = "CopyTagsToSnapshot",
        .db_cluster_identifier = "DBClusterIdentifier",
        .db_instance_class = "DBInstanceClass",
        .db_instance_identifier = "DBInstanceIdentifier",
        .db_instance_port = "DbInstancePort",
        .db_instance_status = "DbInstanceStatus",
        .dbi_resource_id = "DbiResourceId",
        .db_name = "DBName",
        .db_parameter_groups = "DbParameterGroups",
        .db_security_groups = "DbSecurityGroups",
        .db_subnet_group = "DbSubnetGroup",
        .deletion_protection = "DeletionProtection",
        .domain_memberships = "DomainMemberships",
        .enabled_cloud_watch_logs_exports = "EnabledCloudWatchLogsExports",
        .endpoint = "Endpoint",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .enhanced_monitoring_resource_arn = "EnhancedMonitoringResourceArn",
        .iam_database_authentication_enabled = "IAMDatabaseAuthenticationEnabled",
        .instance_create_time = "InstanceCreateTime",
        .iops = "Iops",
        .kms_key_id = "KmsKeyId",
        .latest_restorable_time = "LatestRestorableTime",
        .license_model = "LicenseModel",
        .listener_endpoint = "ListenerEndpoint",
        .master_username = "MasterUsername",
        .max_allocated_storage = "MaxAllocatedStorage",
        .monitoring_interval = "MonitoringInterval",
        .monitoring_role_arn = "MonitoringRoleArn",
        .multi_az = "MultiAz",
        .option_group_memberships = "OptionGroupMemberships",
        .pending_modified_values = "PendingModifiedValues",
        .performance_insights_enabled = "PerformanceInsightsEnabled",
        .performance_insights_kms_key_id = "PerformanceInsightsKmsKeyId",
        .performance_insights_retention_period = "PerformanceInsightsRetentionPeriod",
        .preferred_backup_window = "PreferredBackupWindow",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .processor_features = "ProcessorFeatures",
        .promotion_tier = "PromotionTier",
        .publicly_accessible = "PubliclyAccessible",
        .read_replica_db_cluster_identifiers = "ReadReplicaDBClusterIdentifiers",
        .read_replica_db_instance_identifiers = "ReadReplicaDBInstanceIdentifiers",
        .read_replica_source_db_instance_identifier = "ReadReplicaSourceDBInstanceIdentifier",
        .secondary_availability_zone = "SecondaryAvailabilityZone",
        .status_infos = "StatusInfos",
        .storage_encrypted = "StorageEncrypted",
        .storage_type = "StorageType",
        .tde_credential_arn = "TdeCredentialArn",
        .timezone = "Timezone",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
