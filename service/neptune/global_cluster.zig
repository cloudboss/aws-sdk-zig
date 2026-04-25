const FailoverState = @import("failover_state.zig").FailoverState;
const GlobalClusterMember = @import("global_cluster_member.zig").GlobalClusterMember;
const Tag = @import("tag.zig").Tag;

/// Contains the details of an Amazon Neptune global database.
///
/// This data type is used as a response element for the
/// CreateGlobalCluster,
/// DescribeGlobalClusters,
/// ModifyGlobalCluster,
/// DeleteGlobalCluster,
/// FailoverGlobalCluster, and
/// RemoveFromGlobalCluster actions.
pub const GlobalCluster = struct {
    /// The default database name within the new global database cluster.
    database_name: ?[]const u8 = null,

    /// The deletion protection setting for the global database.
    deletion_protection: ?bool = null,

    /// The Neptune database engine used by the global database
    /// (`"neptune"`).
    engine: ?[]const u8 = null,

    /// The Neptune engine version used by the global database.
    engine_version: ?[]const u8 = null,

    /// A data object containing all properties for the current state of an
    /// in-process or pending switchover or failover process for this global cluster
    /// (Neptune global database).
    /// This object is empty unless the `SwitchoverGlobalCluster` or
    /// `FailoverGlobalCluster` operation was called on this global cluster.
    failover_state: ?FailoverState = null,

    /// The Amazon Resource Name (ARN) for the global database.
    global_cluster_arn: ?[]const u8 = null,

    /// Contains a user-supplied global database cluster identifier. This identifier
    /// is the unique key that identifies a global database.
    global_cluster_identifier: ?[]const u8 = null,

    /// A list of cluster ARNs and instance ARNs for all the DB clusters
    /// that are part of the global database.
    global_cluster_members: ?[]const GlobalClusterMember = null,

    /// An immutable identifier for the global database that is unique within all
    /// regions. This identifier is found in CloudTrail log entries whenever the KMS
    /// key for the DB cluster is accessed.
    global_cluster_resource_id: ?[]const u8 = null,

    /// Specifies the current state of this global database.
    status: ?[]const u8 = null,

    /// The storage encryption setting for the global database.
    storage_encrypted: ?bool = null,

    /// A list of global cluster tags.
    tag_list: ?[]const Tag = null,
};
