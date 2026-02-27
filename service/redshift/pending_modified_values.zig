/// Describes cluster attributes that are in a pending state. A change to one or
/// more
/// the attributes was requested and is in progress or will be applied.
pub const PendingModifiedValues = struct {
    /// The pending or in-progress change of the automated snapshot retention
    /// period.
    automated_snapshot_retention_period: ?i32,

    /// The pending or in-progress change of the new identifier for the cluster.
    cluster_identifier: ?[]const u8,

    /// The pending or in-progress change of the cluster type.
    cluster_type: ?[]const u8,

    /// The pending or in-progress change of the service version.
    cluster_version: ?[]const u8,

    /// The encryption type for a cluster. Possible values are: KMS and None.
    encryption_type: ?[]const u8,

    /// An option that specifies whether to create the cluster with enhanced VPC
    /// routing
    /// enabled. To create a cluster that uses enhanced VPC routing, the cluster
    /// must be in a
    /// VPC. For more information, see [Enhanced VPC
    /// Routing](https://docs.aws.amazon.com/redshift/latest/mgmt/enhanced-vpc-routing.html) in
    /// the Amazon Redshift Cluster Management Guide.
    ///
    /// If this option is `true`, enhanced VPC routing is enabled.
    ///
    /// Default: false
    enhanced_vpc_routing: ?bool,

    /// The name of the maintenance track that the cluster will change to during the
    /// next
    /// maintenance window.
    maintenance_track_name: ?[]const u8,

    /// The pending or in-progress change of the admin user password for the
    /// cluster.
    master_user_password: ?[]const u8,

    /// The pending or in-progress change of the cluster's node type.
    node_type: ?[]const u8,

    /// The pending or in-progress change of the number of nodes in the cluster.
    number_of_nodes: ?i32,

    /// The pending or in-progress change of the ability to connect to the cluster
    /// from the
    /// public network.
    publicly_accessible: ?bool,
};
