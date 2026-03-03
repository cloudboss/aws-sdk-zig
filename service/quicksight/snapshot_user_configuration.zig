const SnapshotAnonymousUser = @import("snapshot_anonymous_user.zig").SnapshotAnonymousUser;

/// A structure that contains information about the users that the dashboard
/// snapshot is generated for.
///
/// When using identity-enhanced session credentials, set the UserConfiguration
/// request attribute to null. Otherwise, the request will be invalid.
pub const SnapshotUserConfiguration = struct {
    /// An array of records that describe the anonymous users that the dashboard
    /// snapshot is generated for.
    anonymous_users: ?[]const SnapshotAnonymousUser = null,

    pub const json_field_names = .{
        .anonymous_users = "AnonymousUsers",
    };
};
