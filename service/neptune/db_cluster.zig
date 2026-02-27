const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const DBClusterOptionGroupStatus = @import("db_cluster_option_group_status.zig").DBClusterOptionGroupStatus;
const ClusterPendingModifiedValues = @import("cluster_pending_modified_values.zig").ClusterPendingModifiedValues;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Contains the details of an Amazon Neptune DB cluster.
///
/// This data type is used as a response element in the DescribeDBClusters.
pub const DBCluster = struct {
    /// `AllocatedStorage` always returns 1, because Neptune DB cluster storage size
    /// is
    /// not fixed, but instead automatically adjusts as needed.
    allocated_storage: ?i32,

    /// Provides a list of the Amazon Identity and Access Management (IAM) roles
    /// that are associated
    /// with the DB cluster. IAM roles that are associated with a DB cluster grant
    /// permission for the
    /// DB cluster to access other Amazon services on your behalf.
    associated_roles: ?[]const DBClusterRole,

    /// Time at which the DB cluster will be automatically restarted.
    automatic_restart_time: ?i64,

    /// Provides the list of EC2 Availability Zones that instances in the DB cluster
    /// can be
    /// created in.
    availability_zones: ?[]const []const u8,

    /// Specifies the number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32,

    /// Not supported by Neptune.
    character_set_name: ?[]const u8,

    /// Identifies the clone group to which the DB cluster is associated.
    clone_group_id: ?[]const u8,

    /// Specifies the time when the DB cluster was created, in Universal Coordinated
    /// Time
    /// (UTC).
    cluster_create_time: ?i64,

    /// *If set to `true`, tags are copied to any snapshot of
    /// the DB cluster that is created.*
    copy_tags_to_snapshot: ?bool,

    /// If set to `true`, the DB cluster can be cloned across accounts.
    cross_account_clone: ?bool,

    /// Contains the name of the initial database of this DB cluster that was
    /// provided at create
    /// time, if one was specified when the DB cluster was created. This same name
    /// is returned for the
    /// life of the DB cluster.
    database_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the DB cluster.
    db_cluster_arn: ?[]const u8,

    /// Contains a user-supplied DB cluster identifier. This identifier is the
    /// unique key that
    /// identifies a DB cluster.
    db_cluster_identifier: ?[]const u8,

    /// Provides the list of instances that make up the DB cluster.
    db_cluster_members: ?[]const DBClusterMember,

    /// Not supported by Neptune.
    db_cluster_option_group_memberships: ?[]const DBClusterOptionGroupStatus,

    /// Specifies the name of the DB cluster parameter group for the DB cluster.
    db_cluster_parameter_group: ?[]const u8,

    /// The Amazon Region-unique, immutable identifier for the DB cluster. This
    /// identifier is found
    /// in Amazon CloudTrail log entries whenever the Amazon KMS key for the DB
    /// cluster is accessed.
    db_cluster_resource_id: ?[]const u8,

    /// Specifies information on the subnet group associated with the DB cluster,
    /// including the
    /// name, description, and subnets in the subnet group.
    db_subnet_group: ?[]const u8,

    /// Indicates whether or not the DB cluster has deletion protection enabled.
    /// The database can't be deleted when deletion protection is enabled.
    deletion_protection: ?bool,

    /// Specifies the earliest time to which a database can be restored with
    /// point-in-time
    /// restore.
    earliest_restorable_time: ?i64,

    /// A list of the log types that this DB cluster is configured to export to
    /// CloudWatch Logs.
    /// Valid log types are: `audit` (to publish audit logs to CloudWatch) and
    /// slowquery (to publish slow-query logs to CloudWatch). See [Publishing
    /// Neptune logs
    /// to Amazon CloudWatch
    /// logs](https://docs.aws.amazon.com/neptune/latest/userguide/cloudwatch-logs.html).
    enabled_cloudwatch_logs_exports: ?[]const []const u8,

    /// Specifies the connection endpoint for the primary instance of the DB
    /// cluster.
    endpoint: ?[]const u8,

    /// Provides the name of the database engine to be used for this DB cluster.
    engine: ?[]const u8,

    /// Indicates the database engine version.
    engine_version: ?[]const u8,

    /// Contains a user-supplied global database cluster identifier.
    /// This identifier is the unique key that identifies a global database.
    global_cluster_identifier: ?[]const u8,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8,

    /// True if mapping of Amazon Identity and Access Management (IAM) accounts to
    /// database accounts
    /// is enabled, and otherwise false.
    iam_database_authentication_enabled: ?bool,

    /// The next time you can modify the DB cluster to use the `iopt1` storage type.
    io_optimized_next_allowed_modification_time: ?i64,

    /// If `StorageEncrypted` is true, the Amazon KMS key identifier for the
    /// encrypted DB cluster.
    kms_key_id: ?[]const u8,

    /// Specifies the latest time to which a database can be restored with
    /// point-in-time
    /// restore.
    latest_restorable_time: ?i64,

    /// Not supported by Neptune.
    master_username: ?[]const u8,

    /// Specifies whether the DB cluster has instances in multiple Availability
    /// Zones.
    multi_az: ?bool,

    /// This data type is used as a response element in the `ModifyDBCluster`
    /// operation and
    /// contains changes that will be applied during the next maintenance window.
    pending_modified_values: ?ClusterPendingModifiedValues,

    /// Specifies the progress of the operation as a percentage.
    percent_progress: ?[]const u8,

    /// Specifies the port that the database engine is listening on.
    port: ?i32,

    /// Specifies the daily time range during which automated backups are created if
    /// automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8,

    /// Specifies the weekly time range during which system maintenance can occur,
    /// in Universal
    /// Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8,

    /// The reader endpoint for the DB cluster. The reader endpoint for a DB cluster
    /// load-balances
    /// connections across the Read Replicas that are available in a DB cluster. As
    /// clients request
    /// new connections to the reader endpoint, Neptune distributes the connection
    /// requests among the
    /// Read Replicas in the DB cluster. This functionality can help balance your
    /// read workload across
    /// multiple Read Replicas in your DB cluster.
    ///
    /// If a failover occurs, and the Read Replica that you are connected to is
    /// promoted to be the
    /// primary instance, your connection is dropped. To continue sending your read
    /// workload to other
    /// Read Replicas in the cluster, you can then reconnect to the reader endpoint.
    reader_endpoint: ?[]const u8,

    /// Contains one or more identifiers of the Read Replicas associated with this
    /// DB
    /// cluster.
    read_replica_identifiers: ?[]const []const u8,

    /// Not supported by Neptune.
    replication_source_identifier: ?[]const u8,

    /// Shows the scaling configuration for a Neptune Serverless DB cluster.
    ///
    /// For more information, see [Using Amazon Neptune
    /// Serverless](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-serverless-using.html) in the
    /// *Amazon Neptune User Guide*.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfigurationInfo,

    /// Specifies the current state of this DB cluster.
    status: ?[]const u8,

    /// Specifies whether the DB cluster is encrypted.
    storage_encrypted: ?bool,

    /// The storage type used by the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * **
    /// `standard`
    /// **   –
    /// ( *the default* ) Provides cost-effective database storage for applications
    /// with moderate to small I/O usage.
    ///
    /// * **
    /// `iopt1`
    /// **   –
    /// Enables [I/O-Optimized
    /// storage](https://docs.aws.amazon.com/neptune/latest/userguide/storage-types.html#provisioned-iops-storage)
    /// that's designed to meet the needs of I/O-intensive graph workloads that
    /// require predictable pricing with low I/O latency and consistent I/O
    /// throughput.
    ///
    /// Neptune I/O-Optimized storage is only available starting with engine release
    /// 1.3.0.0.
    storage_type: ?[]const u8,

    /// Provides a list of VPC security groups that the DB cluster belongs to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership,
};
