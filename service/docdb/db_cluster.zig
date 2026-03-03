const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const ClusterMasterUserSecret = @import("cluster_master_user_secret.zig").ClusterMasterUserSecret;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Detailed information about a cluster.
pub const DBCluster = struct {
    /// Provides a list of the Identity and Access Management (IAM) roles that are
    /// associated with the cluster. (IAM) roles that are associated with a cluster
    /// grant permission for the cluster to access other Amazon Web Services
    /// services on your behalf.
    associated_roles: ?[]const DBClusterRole = null,

    /// Provides the list of Amazon EC2 Availability Zones that instances in the
    /// cluster
    /// can be created in.
    availability_zones: ?[]const []const u8 = null,

    /// Specifies the number of days for which automatic snapshots are retained.
    backup_retention_period: ?i32 = null,

    /// Identifies the clone group to which the DB cluster is associated.
    clone_group_id: ?[]const u8 = null,

    /// Specifies the time when the cluster was created, in Universal Coordinated
    /// Time
    /// (UTC).
    cluster_create_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the cluster.
    db_cluster_arn: ?[]const u8 = null,

    /// Contains a user-supplied cluster identifier. This identifier is the unique
    /// key that
    /// identifies a cluster.
    db_cluster_identifier: ?[]const u8 = null,

    /// Provides the list of instances that make up the cluster.
    db_cluster_members: ?[]const DBClusterMember = null,

    /// Specifies the name of the cluster parameter group for the cluster.
    db_cluster_parameter_group: ?[]const u8 = null,

    /// The Amazon Web Services Region-unique, immutable identifier for the cluster.
    /// This identifier is
    /// found in CloudTrail log entries whenever the KMS key for the cluster is
    /// accessed.
    db_cluster_resource_id: ?[]const u8 = null,

    /// Specifies information on the subnet group that is associated with the
    /// cluster, including the name, description, and subnets in the subnet group.
    db_subnet_group: ?[]const u8 = null,

    /// Specifies whether this cluster can be deleted. If `DeletionProtection` is
    /// enabled, the cluster cannot be deleted unless it is modified and
    /// `DeletionProtection` is disabled. `DeletionProtection`
    /// protects clusters from being accidentally deleted.
    deletion_protection: ?bool = null,

    /// The earliest time to which a database can be restored with point-in-time
    /// restore.
    earliest_restorable_time: ?i64 = null,

    /// A list of log types that this cluster is configured to export to Amazon
    /// CloudWatch
    /// Logs.
    enabled_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies the connection endpoint for the primary instance of the cluster.
    endpoint: ?[]const u8 = null,

    /// Provides the name of the database engine to be used for this cluster.
    engine: ?[]const u8 = null,

    /// Indicates the database engine version.
    engine_version: ?[]const u8 = null,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8 = null,

    /// The next time you can modify the Amazon DocumentDB cluster to use the iopt1
    /// storage type.
    io_optimized_next_allowed_modification_time: ?i64 = null,

    /// If `StorageEncrypted` is `true`, the KMS key identifier for
    /// the encrypted cluster.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the latest time to which a database can be restored with
    /// point-in-time
    /// restore.
    latest_restorable_time: ?i64 = null,

    /// Contains the master user name for the cluster.
    master_username: ?[]const u8 = null,

    /// The secret managed by Amazon DocumentDB in Amazon Web Services Secrets
    /// Manager for the master user password.
    master_user_secret: ?ClusterMasterUserSecret = null,

    /// Specifies whether the cluster has instances in multiple Availability Zones.
    multi_az: ?bool = null,

    /// The network type of the cluster.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the
    /// cluster.
    /// A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4 and the
    /// IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [DocumentDB clusters in a
    /// VPC](https://docs.aws.amazon.com/documentdb/latest/developerguide/vpc-clusters.html) in the Amazon DocumentDB Developer Guide.
    ///
    /// Valid Values: `IPV4` | `DUAL`
    network_type: ?[]const u8 = null,

    /// Specifies the progress of the operation as a percentage.
    percent_progress: ?[]const u8 = null,

    /// Specifies the port that the database engine is listening on.
    port: ?i32 = null,

    /// Specifies the daily time range during which automated backups are created if
    /// automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8 = null,

    /// Specifies the weekly time range during which system maintenance can occur,
    /// in
    /// Universal Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8 = null,

    /// The reader endpoint for the cluster. The reader endpoint for a cluster load
    /// balances connections across the Amazon DocumentDB replicas that are
    /// available in a cluster. As clients request new connections to the reader
    /// endpoint, Amazon DocumentDB distributes the connection requests among the
    /// Amazon DocumentDB replicas in the cluster. This functionality can help
    /// balance your read workload across multiple Amazon DocumentDB replicas in
    /// your cluster.
    ///
    /// If a failover occurs, and the Amazon DocumentDB replica that you are
    /// connected to is promoted to be the primary instance, your connection is
    /// dropped. To continue sending your read workload to other Amazon DocumentDB
    /// replicas in the cluster, you can then reconnect to the reader endpoint.
    reader_endpoint: ?[]const u8 = null,

    /// Contains one or more identifiers of the secondary clusters that are
    /// associated with this cluster.
    read_replica_identifiers: ?[]const []const u8 = null,

    /// Contains the identifier of the source cluster if this cluster is a secondary
    /// cluster.
    replication_source_identifier: ?[]const u8 = null,

    /// The scaling configuration of an Amazon DocumentDB Serverless cluster.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfigurationInfo = null,

    /// Specifies the current state of this cluster.
    status: ?[]const u8 = null,

    /// Specifies whether the cluster is encrypted.
    storage_encrypted: ?bool = null,

    /// Storage type associated with your cluster
    ///
    /// For information on storage types for Amazon DocumentDB clusters, see
    /// Cluster storage configurations in the *Amazon DocumentDB Developer Guide*.
    ///
    /// Valid values for storage type - `standard | iopt1`
    ///
    /// Default value is `standard `
    storage_type: ?[]const u8 = null,

    /// Provides a list of virtual private cloud (VPC) security groups that the
    /// cluster
    /// belongs to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,
};
