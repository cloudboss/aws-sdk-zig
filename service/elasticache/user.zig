const Authentication = @import("authentication.zig").Authentication;

pub const User = struct {
    /// Access permissions string used for this user.
    access_string: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user.
    arn: ?[]const u8 = null,

    /// Denotes whether the user requires a password to authenticate.
    authentication: ?Authentication = null,

    /// The options are valkey or redis.
    engine: ?[]const u8 = null,

    /// The minimum engine version required, which is Redis OSS 6.0
    minimum_engine_version: ?[]const u8 = null,

    /// Indicates the user status. Can be "active", "modifying" or "deleting".
    status: ?[]const u8 = null,

    /// Returns a list of the user group IDs the user belongs to.
    user_group_ids: ?[]const []const u8 = null,

    /// The ID of the user.
    user_id: ?[]const u8 = null,

    /// The username of the user.
    user_name: ?[]const u8 = null,
};
