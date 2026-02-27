const ScopePermission = @import("scope_permission.zig").ScopePermission;

/// You can use the access point scope to restrict access to specific prefixes,
/// API operations, or a combination of both.
///
/// For more information, see [Manage the scope of your access points for
/// directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-directory-buckets-manage-scope.html).
pub const Scope = struct {
    /// You can include one or more API operations as permissions.
    permissions: ?[]const ScopePermission,

    /// You can specify any amount of prefixes, but the total length of characters
    /// of all prefixes must be less than 256 bytes in size.
    prefixes: ?[]const []const u8,
};
