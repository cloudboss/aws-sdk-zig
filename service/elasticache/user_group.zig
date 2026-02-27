const UserGroupPendingChanges = @import("user_group_pending_changes.zig").UserGroupPendingChanges;

pub const UserGroup = struct {
    /// The Amazon Resource Name (ARN) of the user group.
    arn: ?[]const u8,

    /// The options are valkey or redis.
    engine: ?[]const u8,

    /// The minimum engine version required, which is Redis OSS 6.0
    minimum_engine_version: ?[]const u8,

    /// A list of updates being applied to the user group.
    pending_changes: ?UserGroupPendingChanges,

    /// A list of replication groups that the user group can access.
    replication_groups: ?[]const []const u8,

    /// Indicates which serverless caches the specified user group is associated
    /// with. Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_caches: ?[]const []const u8,

    /// Indicates user group status. Can be "creating", "active", "modifying",
    /// "deleting".
    status: ?[]const u8,

    /// The ID of the user group.
    user_group_id: ?[]const u8,

    /// The list of user IDs that belong to the user group.
    user_ids: ?[]const []const u8,
};
