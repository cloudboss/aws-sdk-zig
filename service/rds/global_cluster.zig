const FailoverState = @import("failover_state.zig").FailoverState;
const GlobalClusterMember = @import("global_cluster_member.zig").GlobalClusterMember;
const Tag = @import("tag.zig").Tag;

/// A data type representing an Aurora global database.
pub const GlobalCluster = struct {
    /// The default database name within the new global database cluster.
    database_name: ?[]const u8 = null,

    /// The deletion protection setting for the new global database cluster.
    deletion_protection: ?bool = null,

    /// The writer endpoint for the new global database cluster. This endpoint
    /// always points to the writer DB instance in the current primary cluster.
    endpoint: ?[]const u8 = null,

    /// The Aurora database engine used by the global database cluster.
    engine: ?[]const u8 = null,

    /// The lifecycle type for the global cluster.
    ///
    /// For more information, see CreateGlobalCluster.
    engine_lifecycle_support: ?[]const u8 = null,

    /// Indicates the database engine version.
    engine_version: ?[]const u8 = null,

    /// A data object containing all properties for the current state of an
    /// in-process or pending switchover or failover process for this global cluster
    /// (Aurora global database). This object is empty unless the
    /// `SwitchoverGlobalCluster` or `FailoverGlobalCluster` operation was called on
    /// this global cluster.
    failover_state: ?FailoverState = null,

    /// The Amazon Resource Name (ARN) for the global database cluster.
    global_cluster_arn: ?[]const u8 = null,

    /// Contains a user-supplied global database cluster identifier. This identifier
    /// is the unique key that identifies a global database cluster.
    global_cluster_identifier: ?[]const u8 = null,

    /// The list of primary and secondary clusters within the global database
    /// cluster.
    global_cluster_members: ?[]const GlobalClusterMember = null,

    /// The Amazon Web Services
    /// [partition](https://docs.aws.amazon.com/glossary/latest/reference/glos-chap.html?id=docs_gateway#partition)-unique, immutable identifier for the global database cluster. This identifier is found in Amazon Web Services CloudTrail log entries whenever the Amazon Web Services KMS key for the DB cluster is accessed.
    global_cluster_resource_id: ?[]const u8 = null,

    /// Specifies the current state of this global database cluster.
    status: ?[]const u8 = null,

    /// The storage encryption setting for the global database cluster.
    storage_encrypted: ?bool = null,

    tag_list: ?[]const Tag = null,
};
