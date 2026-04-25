const ActivityStreamMode = @import("activity_stream_mode.zig").ActivityStreamMode;
const ActivityStreamStatus = @import("activity_stream_status.zig").ActivityStreamStatus;
const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const ClusterScalabilityType = @import("cluster_scalability_type.zig").ClusterScalabilityType;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const DBClusterOptionGroupStatus = @import("db_cluster_option_group_status.zig").DBClusterOptionGroupStatus;
const DomainMembership = @import("domain_membership.zig").DomainMembership;
const WriteForwardingStatus = @import("write_forwarding_status.zig").WriteForwardingStatus;
const LimitlessDatabase = @import("limitless_database.zig").LimitlessDatabase;
const LocalWriteForwardingStatus = @import("local_write_forwarding_status.zig").LocalWriteForwardingStatus;
const MasterUserSecret = @import("master_user_secret.zig").MasterUserSecret;
const ClusterPendingModifiedValues = @import("cluster_pending_modified_values.zig").ClusterPendingModifiedValues;
const RdsCustomClusterConfiguration = @import("rds_custom_cluster_configuration.zig").RdsCustomClusterConfiguration;
const ScalingConfigurationInfo = @import("scaling_configuration_info.zig").ScalingConfigurationInfo;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const DBClusterStatusInfo = @import("db_cluster_status_info.zig").DBClusterStatusInfo;
const StorageEncryptionType = @import("storage_encryption_type.zig").StorageEncryptionType;
const Tag = @import("tag.zig").Tag;
const UpgradeRolloutOrder = @import("upgrade_rollout_order.zig").UpgradeRolloutOrder;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Contains the details of an Amazon Aurora DB cluster or Multi-AZ DB cluster.
///
/// For an Amazon Aurora DB cluster, this data type is used as a response
/// element in the operations `CreateDBCluster`, `DeleteDBCluster`,
/// `DescribeDBClusters`, `FailoverDBCluster`, `ModifyDBCluster`,
/// `PromoteReadReplicaDBCluster`, `RestoreDBClusterFromS3`,
/// `RestoreDBClusterFromSnapshot`, `RestoreDBClusterToPointInTime`,
/// `StartDBCluster`, and `StopDBCluster`.
///
/// For a Multi-AZ DB cluster, this data type is used as a response element in
/// the operations `CreateDBCluster`, `DeleteDBCluster`, `DescribeDBClusters`,
/// `FailoverDBCluster`, `ModifyDBCluster`, `RebootDBCluster`,
/// `RestoreDBClusterFromSnapshot`, and `RestoreDBClusterToPointInTime`.
///
/// For more information on Amazon Aurora DB clusters, see [ What is Amazon
/// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide.*
///
/// For more information on Multi-AZ DB clusters, see [ Multi-AZ deployments
/// with two readable standby DB
/// instances](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
pub const DBCluster = struct {
    /// The name of the Amazon Kinesis data stream used for the database activity
    /// stream.
    activity_stream_kinesis_stream_name: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier used for encrypting messages in
    /// the database activity stream.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    activity_stream_kms_key_id: ?[]const u8 = null,

    /// The mode of the database activity stream. Database events such as a change
    /// or access generate an activity stream event. The database session can handle
    /// these events either synchronously or asynchronously.
    activity_stream_mode: ?ActivityStreamMode = null,

    /// The status of the database activity stream.
    activity_stream_status: ?ActivityStreamStatus = null,

    /// `AllocatedStorage` specifies the allocated storage size in gibibytes (GiB).
    /// For Aurora, `AllocatedStorage` can vary because Aurora DB cluster storage
    /// size adjusts as needed.
    allocated_storage: ?i32 = null,

    /// A list of the Amazon Web Services Identity and Access Management (IAM) roles
    /// that are associated with the DB cluster. IAM roles that are associated with
    /// a DB cluster grant permission for the DB cluster to access other Amazon Web
    /// Services on your behalf.
    associated_roles: ?[]const DBClusterRole = null,

    /// The time when a stopped DB cluster is restarted automatically.
    automatic_restart_time: ?i64 = null,

    /// Indicates whether minor version patches are applied automatically.
    ///
    /// This setting is for Aurora DB clusters and Multi-AZ DB clusters.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// The list of Availability Zones (AZs) where instances in the DB cluster can
    /// be created.
    availability_zones: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    aws_backup_recovery_point_arn: ?[]const u8 = null,

    /// The number of change records stored for Backtrack.
    backtrack_consumed_change_records: ?i64 = null,

    /// The target backtrack window, in seconds. If this value is set to `0`,
    /// backtracking is disabled for the DB cluster. Otherwise, backtracking is
    /// enabled.
    backtrack_window: ?i64 = null,

    /// The number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32 = null,

    /// The current capacity of an Aurora Serverless v1 DB cluster. The capacity is
    /// `0` (zero) when the cluster is paused.
    ///
    /// For more information about Aurora Serverless v1, see [Using Amazon Aurora
    /// Serverless
    /// v1](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html) in the *Amazon Aurora User Guide*.
    capacity: ?i32 = null,

    certificate_details: ?CertificateDetails = null,

    /// If present, specifies the name of the character set that this cluster is
    /// associated with.
    character_set_name: ?[]const u8 = null,

    /// The ID of the clone group with which the DB cluster is associated. For newly
    /// created clusters, the ID is typically null.
    ///
    /// If you clone a DB cluster when the ID is null, the operation populates the
    /// ID value for the source cluster and the clone because both clusters become
    /// part of the same clone group. Even if you delete the clone cluster, the
    /// clone group ID remains for the lifetime of the source cluster to show that
    /// it was used in a cloning operation.
    ///
    /// For PITR, the clone group ID is inherited from the source cluster. For
    /// snapshot restore operations, the clone group ID isn't inherited from the
    /// source cluster.
    clone_group_id: ?[]const u8 = null,

    /// The time when the DB cluster was created, in Universal Coordinated Time
    /// (UTC).
    cluster_create_time: ?i64 = null,

    /// The scalability mode of the Aurora DB cluster. When set to `limitless`, the
    /// cluster operates as an Aurora Limitless Database. When set to `standard`
    /// (the default), the cluster uses normal DB instance creation.
    cluster_scalability_type: ?ClusterScalabilityType = null,

    /// Indicates whether tags are copied from the DB cluster to snapshots of the DB
    /// cluster.
    copy_tags_to_snapshot: ?bool = null,

    /// Indicates whether the DB cluster is a clone of a DB cluster owned by a
    /// different Amazon Web Services account.
    cross_account_clone: ?bool = null,

    /// The custom endpoints associated with the DB cluster.
    custom_endpoints: ?[]const []const u8 = null,

    /// The mode of Database Insights that is enabled for the DB cluster.
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The name of the initial database that was specified for the DB cluster when
    /// it was created, if one was provided. This same name is returned for the life
    /// of the DB cluster.
    database_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the DB cluster.
    db_cluster_arn: ?[]const u8 = null,

    /// The user-supplied identifier for the DB cluster. This identifier is the
    /// unique key that identifies a DB cluster.
    db_cluster_identifier: ?[]const u8 = null,

    /// The name of the compute and memory capacity class of the DB instance.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    db_cluster_instance_class: ?[]const u8 = null,

    /// The list of DB instances that make up the DB cluster.
    db_cluster_members: ?[]const DBClusterMember = null,

    /// The list of option group memberships for this DB cluster.
    db_cluster_option_group_memberships: ?[]const DBClusterOptionGroupStatus = null,

    /// The name of the DB cluster parameter group for the DB cluster.
    db_cluster_parameter_group: ?[]const u8 = null,

    /// The Amazon Web Services Region-unique, immutable identifier for the DB
    /// cluster. This identifier is found in Amazon Web Services CloudTrail log
    /// entries whenever the KMS key for the DB cluster is accessed.
    db_cluster_resource_id: ?[]const u8 = null,

    /// Information about the subnet group associated with the DB cluster, including
    /// the name, description, and subnets in the subnet group.
    db_subnet_group: ?[]const u8 = null,

    /// Reserved for future use.
    db_system_id: ?[]const u8 = null,

    /// Indicates whether the DB cluster has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled.
    deletion_protection: ?bool = null,

    /// The Active Directory Domain membership records associated with the DB
    /// cluster.
    domain_memberships: ?[]const DomainMembership = null,

    /// The earliest time to which a DB cluster can be backtracked.
    earliest_backtrack_time: ?i64 = null,

    /// The earliest time to which a database can be restored with point-in-time
    /// restore.
    earliest_restorable_time: ?i64 = null,

    /// A list of log types that this DB cluster is configured to export to
    /// CloudWatch Logs.
    ///
    /// Log types vary by DB engine. For information about the log types for each DB
    /// engine, see [Amazon RDS Database Log
    /// Files](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html) in the *Amazon Aurora User Guide.*
    enabled_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// The connection endpoint for the primary instance of the DB cluster.
    endpoint: ?[]const u8 = null,

    /// The database engine used for this DB cluster.
    engine: ?[]const u8 = null,

    /// The lifecycle type for the DB cluster.
    ///
    /// For more information, see CreateDBCluster.
    engine_lifecycle_support: ?[]const u8 = null,

    /// The DB engine mode of the DB cluster, either `provisioned` or `serverless`.
    ///
    /// For more information, see [
    /// CreateDBCluster](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBCluster.html).
    engine_mode: ?[]const u8 = null,

    /// The version of the database engine.
    engine_version: ?[]const u8 = null,

    /// Contains a user-supplied global database cluster identifier. This identifier
    /// is the unique key that identifies a global database cluster.
    global_cluster_identifier: ?[]const u8 = null,

    /// Indicates whether write forwarding is enabled for a secondary cluster in an
    /// Aurora global database. Because write forwarding takes time to enable, check
    /// the value of `GlobalWriteForwardingStatus` to confirm that the request has
    /// completed before using the write forwarding feature for this cluster.
    global_write_forwarding_requested: ?bool = null,

    /// The status of write forwarding for a secondary cluster in an Aurora global
    /// database.
    global_write_forwarding_status: ?WriteForwardingStatus = null,

    /// The ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8 = null,

    /// Indicates whether the HTTP endpoint is enabled for an Aurora DB cluster.
    ///
    /// When enabled, the HTTP endpoint provides a connectionless web service API
    /// (RDS Data API) for running SQL queries on the DB cluster. You can also query
    /// your database from inside the RDS console with the RDS query editor.
    ///
    /// For more information, see [Using RDS Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    http_endpoint_enabled: ?bool = null,

    /// Indicates whether the mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool = null,

    /// Indicates whether the DB cluster has internet-based connectivity enabled
    /// through an internet access gateway.
    ///
    /// This setting is applicable only for Aurora PostgreSQL clusters created
    /// through express configuration.
    internet_access_gateway_enabled: ?bool = null,

    /// The next time you can modify the DB cluster to use the `aurora-iopt1`
    /// storage type.
    ///
    /// This setting is only for Aurora DB clusters.
    io_optimized_next_allowed_modification_time: ?i64 = null,

    /// The Provisioned IOPS (I/O operations per second) value.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    iops: ?i32 = null,

    /// If `StorageEncrypted` is enabled, the Amazon Web Services KMS key identifier
    /// for the encrypted DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The latest time to which a database can be restored with point-in-time
    /// restore.
    latest_restorable_time: ?i64 = null,

    /// The details for Aurora Limitless Database.
    limitless_database: ?LimitlessDatabase = null,

    /// Indicates whether an Aurora DB cluster has in-cluster write forwarding
    /// enabled, not enabled, requested, or is in the process of enabling it.
    local_write_forwarding_status: ?LocalWriteForwardingStatus = null,

    /// The master username for the DB cluster.
    master_username: ?[]const u8 = null,

    /// The secret managed by RDS in Amazon Web Services Secrets Manager for the
    /// master user password.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
    master_user_secret: ?MasterUserSecret = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB cluster.
    ///
    /// This setting is only for -Aurora DB clusters and Multi-AZ DB clusters.
    monitoring_interval: ?i32 = null,

    /// The ARN for the IAM role that permits RDS to send Enhanced Monitoring
    /// metrics to Amazon CloudWatch Logs.
    ///
    /// This setting is only for Aurora DB clusters and Multi-AZ DB clusters.
    monitoring_role_arn: ?[]const u8 = null,

    /// Indicates whether the DB cluster has instances in multiple Availability
    /// Zones.
    multi_az: ?bool = null,

    /// The network type of the DB instance.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the DB
    /// cluster. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon Aurora User Guide.*
    ///
    /// This setting is only for Aurora DB clusters.
    ///
    /// Valid Values: `IPV4 | DUAL`
    network_type: ?[]const u8 = null,

    /// Information about pending changes to the DB cluster. This information is
    /// returned only when there are pending changes. Specific changes are
    /// identified by subelements.
    pending_modified_values: ?ClusterPendingModifiedValues = null,

    /// The progress of the operation as a percentage.
    percent_progress: ?[]const u8 = null,

    /// Indicates whether Performance Insights is enabled for the DB cluster.
    ///
    /// This setting is only for Aurora DB clusters and Multi-AZ DB clusters.
    performance_insights_enabled: ?bool = null,

    /// The Amazon Web Services KMS key identifier for encryption of Performance
    /// Insights data.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// This setting is only for Aurora DB clusters and Multi-AZ DB clusters.
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The number of days to retain Performance Insights data.
    ///
    /// This setting is only for Aurora DB clusters and Multi-AZ DB clusters.
    ///
    /// Valid Values:
    ///
    /// * `7`
    /// * *month* * 31, where *month* is a number of months from 1-23. Examples:
    ///   `93` (3 months * 31), `341` (11 months * 31), `589` (19 months * 31)
    /// * `731`
    ///
    /// Default: `7` days
    performance_insights_retention_period: ?i32 = null,

    /// The port that the database engine is listening on.
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8 = null,

    /// Indicates whether the DB cluster is publicly accessible.
    ///
    /// When the DB cluster is publicly accessible and you connect from outside of
    /// the DB cluster's virtual private cloud (VPC), its Domain Name System (DNS)
    /// endpoint resolves to the public IP address. When you connect from within the
    /// same VPC as the DB cluster, the endpoint resolves to the private IP address.
    /// Access to the DB cluster is ultimately controlled by the security group it
    /// uses. That public access isn't permitted if the security group assigned to
    /// the DB cluster doesn't permit it.
    ///
    /// When the DB cluster isn't publicly accessible, it is an internal DB cluster
    /// with a DNS name that resolves to a private IP address.
    ///
    /// For more information, see CreateDBCluster.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    publicly_accessible: ?bool = null,

    /// Reserved for future use.
    rds_custom_cluster_configuration: ?RdsCustomClusterConfiguration = null,

    /// The reader endpoint for the DB cluster. The reader endpoint for a DB cluster
    /// load-balances connections across the Aurora Replicas that are available in a
    /// DB cluster. As clients request new connections to the reader endpoint,
    /// Aurora distributes the connection requests among the Aurora Replicas in the
    /// DB cluster. This functionality can help balance your read workload across
    /// multiple Aurora Replicas in your DB cluster.
    ///
    /// If a failover occurs, and the Aurora Replica that you are connected to is
    /// promoted to be the primary instance, your connection is dropped. To continue
    /// sending your read workload to other Aurora Replicas in the cluster, you can
    /// then reconnect to the reader endpoint.
    reader_endpoint: ?[]const u8 = null,

    /// Contains one or more identifiers of the read replicas associated with this
    /// DB cluster.
    read_replica_identifiers: ?[]const []const u8 = null,

    /// The identifier of the source DB cluster if this DB cluster is a read
    /// replica.
    replication_source_identifier: ?[]const u8 = null,

    scaling_configuration_info: ?ScalingConfigurationInfo = null,

    /// The version of the Aurora Serverless V2 platform used by the DB cluster. For
    /// more information, see [Using Aurora Serverless
    /// v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html) in the *Amazon Aurora User Guide*.
    serverless_v2_platform_version: ?[]const u8 = null,

    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfigurationInfo = null,

    /// The current state of this DB cluster.
    status: ?[]const u8 = null,

    /// Reserved for future use.
    status_infos: ?[]const DBClusterStatusInfo = null,

    /// Indicates whether the DB cluster is encrypted.
    storage_encrypted: ?bool = null,

    /// The type of encryption used to protect data at rest in the DB cluster.
    /// Possible values:
    ///
    /// * `none` - The DB cluster is not encrypted.
    /// * `sse-rds` - The DB cluster is encrypted using an Amazon Web Services owned
    ///   KMS key.
    /// * `sse-kms` - The DB cluster is encrypted using a customer managed KMS key
    ///   or Amazon Web Services managed KMS key.
    storage_encryption_type: ?StorageEncryptionType = null,

    /// The storage throughput for the DB cluster. The throughput is automatically
    /// set based on the IOPS that you provision, and is not configurable.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    storage_throughput: ?i32 = null,

    /// The storage type associated with the DB cluster.
    storage_type: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    /// This data type represents the order in which the clusters are upgraded.
    ///
    /// * [first] - Typically used for development or testing environments.
    /// * [second] - Default order for resources not specifically configured.
    /// * [last] - Usually reserved for production environments.
    upgrade_rollout_order: ?UpgradeRolloutOrder = null,

    /// Indicates whether the DB cluster uses VPC-based networking.
    ///
    /// This setting is applicable only for Aurora PostgreSQL clusters created
    /// through express configuration.
    vpc_networking_enabled: ?bool = null,

    /// The list of VPC security groups that the DB cluster belongs to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,
};
