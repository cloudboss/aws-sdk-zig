const GlobalNodeGroup = @import("global_node_group.zig").GlobalNodeGroup;
const GlobalReplicationGroupMember = @import("global_replication_group_member.zig").GlobalReplicationGroupMember;

/// Consists of a primary cluster that accepts writes and an associated
/// secondary cluster
/// that resides in a different Amazon region. The secondary cluster accepts
/// only reads. The
/// primary cluster automatically replicates updates to the secondary cluster.
///
/// * The **GlobalReplicationGroupIdSuffix** represents
/// the name of the Global datastore, which is what you use to associate a
/// secondary
/// cluster.
pub const GlobalReplicationGroup = struct {
    /// The ARN (Amazon Resource Name) of the global replication group.
    arn: ?[]const u8,

    /// A flag that enables encryption at rest when set to `true`.
    ///
    /// You cannot modify the value of `AtRestEncryptionEnabled` after the
    /// replication group is created. To enable encryption at rest on a replication
    /// group you
    /// must set `AtRestEncryptionEnabled` to `true` when you create the
    /// replication group.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    at_rest_encryption_enabled: ?bool,

    /// A flag that enables using an `AuthToken` (password) when issuing Valkey or
    /// Redis OSS
    /// commands.
    ///
    /// Default: `false`
    auth_token_enabled: ?bool,

    /// The cache node type of the Global datastore
    cache_node_type: ?[]const u8,

    /// A flag that indicates whether the Global datastore is cluster enabled.
    cluster_enabled: ?bool,

    /// The ElastiCache engine. For Valkey or Redis OSS only.
    engine: ?[]const u8,

    /// The ElastiCache engine version.
    engine_version: ?[]const u8,

    /// Indicates the slot configuration and global identifier for each slice group.
    global_node_groups: ?[]const GlobalNodeGroup,

    /// The optional description of the Global datastore
    global_replication_group_description: ?[]const u8,

    /// The name of the Global datastore
    global_replication_group_id: ?[]const u8,

    /// The replication groups that comprise the Global datastore.
    members: ?[]const GlobalReplicationGroupMember,

    /// The status of the Global datastore
    status: ?[]const u8,

    /// A flag that enables in-transit encryption when set to true.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    transit_encryption_enabled: ?bool,
};
