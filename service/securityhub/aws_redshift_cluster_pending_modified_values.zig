/// Changes to the Amazon Redshift cluster that are currently pending.
pub const AwsRedshiftClusterPendingModifiedValues = struct {
    /// The pending or in-progress change to the automated snapshot retention
    /// period.
    automated_snapshot_retention_period: ?i32 = null,

    /// The pending or in-progress change to the identifier for the cluster.
    cluster_identifier: ?[]const u8 = null,

    /// The pending or in-progress change to the cluster type.
    cluster_type: ?[]const u8 = null,

    /// The pending or in-progress change to the service version.
    cluster_version: ?[]const u8 = null,

    /// The encryption type for a cluster.
    encryption_type: ?[]const u8 = null,

    /// Indicates whether to create the cluster with enhanced VPC routing enabled.
    enhanced_vpc_routing: ?bool = null,

    /// The name of the maintenance track that the cluster changes to during the
    /// next
    /// maintenance window.
    maintenance_track_name: ?[]const u8 = null,

    /// The pending or in-progress change to the master user password for the
    /// cluster.
    master_user_password: ?[]const u8 = null,

    /// The pending or in-progress change to the cluster's node type.
    node_type: ?[]const u8 = null,

    /// The pending or in-progress change to the number of nodes in the cluster.
    number_of_nodes: ?i32 = null,

    /// The pending or in-progress change to whether the cluster can be connected to
    /// from the
    /// public network.
    publicly_accessible: ?bool = null,

    pub const json_field_names = .{
        .automated_snapshot_retention_period = "AutomatedSnapshotRetentionPeriod",
        .cluster_identifier = "ClusterIdentifier",
        .cluster_type = "ClusterType",
        .cluster_version = "ClusterVersion",
        .encryption_type = "EncryptionType",
        .enhanced_vpc_routing = "EnhancedVpcRouting",
        .maintenance_track_name = "MaintenanceTrackName",
        .master_user_password = "MasterUserPassword",
        .node_type = "NodeType",
        .number_of_nodes = "NumberOfNodes",
        .publicly_accessible = "PubliclyAccessible",
    };
};
