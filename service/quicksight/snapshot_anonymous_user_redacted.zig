/// Use this structure to redact sensitive information that you provide about an
/// anonymous user from the snapshot.
pub const SnapshotAnonymousUserRedacted = struct {
    /// The tag keys for the `RowLevelPermissionTags`.
    row_level_permission_tag_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .row_level_permission_tag_keys = "RowLevelPermissionTagKeys",
    };
};
