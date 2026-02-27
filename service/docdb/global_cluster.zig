const FailoverState = @import("failover_state.zig").FailoverState;
const GlobalClusterMember = @import("global_cluster_member.zig").GlobalClusterMember;
const Tag = @import("tag.zig").Tag;

/// A data type representing an Amazon DocumentDB global cluster.
pub const GlobalCluster = struct {
    /// The default database name within the new global cluster.
    database_name: ?[]const u8,

    /// The deletion protection setting for the new global cluster.
    deletion_protection: ?bool,

    /// The Amazon DocumentDB database engine used by the global cluster.
    engine: ?[]const u8,

    /// Indicates the database engine version.
    engine_version: ?[]const u8,

    /// A data object containing all properties for the current state of an
    /// in-process or pending switchover or failover process for this global
    /// cluster.
    /// This object is empty unless the `SwitchoverGlobalCluster` or
    /// `FailoverGlobalCluster` operation was called on this global cluster.
    failover_state: ?FailoverState,

    /// The Amazon Resource Name (ARN) for the global cluster.
    global_cluster_arn: ?[]const u8,

    /// Contains a user-supplied global cluster identifier. This identifier is the
    /// unique key that identifies a global cluster.
    global_cluster_identifier: ?[]const u8,

    /// The list of cluster IDs for secondary clusters within the global cluster.
    /// Currently limited to one item.
    global_cluster_members: ?[]const GlobalClusterMember,

    /// The Amazon Web Services RegionRegion-unique, immutable identifier for the
    /// global database cluster.
    /// This identifier is found in CloudTrail log entries whenever the KMS customer
    /// master key (CMK) for the cluster is accessed.
    global_cluster_resource_id: ?[]const u8,

    /// Specifies the current state of this global cluster.
    status: ?[]const u8,

    /// The storage encryption setting for the global cluster.
    storage_encrypted: ?bool,

    /// A list of global cluster tags.
    tag_list: ?[]const Tag,
};
