const SnapshotAnonymousUserRedacted = @import("snapshot_anonymous_user_redacted.zig").SnapshotAnonymousUserRedacted;

/// A structure that contains information about the users that the dashboard
/// snapshot is generated for. Sensitive user information is excluded.
pub const SnapshotUserConfigurationRedacted = struct {
    /// An array of records that describe anonymous users that the dashboard
    /// snapshot is generated for. Sensitive user information is excluded.
    anonymous_users: ?[]const SnapshotAnonymousUserRedacted = null,

    pub const json_field_names = .{
        .anonymous_users = "AnonymousUsers",
    };
};
