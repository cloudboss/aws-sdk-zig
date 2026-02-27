const ACLPendingChanges = @import("acl_pending_changes.zig").ACLPendingChanges;

/// An Access Control List. You can authenticate users with Access Contol Lists.
///
/// ACLs enable you to control cluster access by grouping users. These Access
/// control lists are designed as a way to organize access to clusters.
pub const ACL = struct {
    /// The Amazon Resource Name (ARN) of the ACL
    arn: ?[]const u8,

    /// A list of clusters associated with the ACL.
    clusters: ?[]const []const u8,

    /// The minimum engine version supported for the ACL
    minimum_engine_version: ?[]const u8,

    /// The name of the Access Control List
    name: ?[]const u8,

    /// A list of updates being applied to the ACL.
    pending_changes: ?ACLPendingChanges,

    /// Indicates ACL status. Can be "creating", "active", "modifying", "deleting".
    status: ?[]const u8,

    /// The list of user names that belong to the ACL.
    user_names: ?[]const []const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .clusters = "Clusters",
        .minimum_engine_version = "MinimumEngineVersion",
        .name = "Name",
        .pending_changes = "PendingChanges",
        .status = "Status",
        .user_names = "UserNames",
    };
};
