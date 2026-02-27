const SessionTag = @import("session_tag.zig").SessionTag;

/// A structure that contains information on the anonymous user configuration.
pub const SnapshotAnonymousUser = struct {
    /// The tags to be used for row-level security (RLS). Make sure that the
    /// relevant datasets have RLS tags configured before you start a snapshot
    /// export job. You can configure the RLS tags of a dataset with a
    /// `DataSet$RowLevelPermissionTagConfiguration` API call.
    ///
    /// These are not the tags that are used for Amazon Web Services resource
    /// tagging. For more information on row level security in Amazon Quick Sight,
    /// see [Using Row-Level Security (RLS) with
    /// Tags](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-rls-tags.html)in the *Amazon Quick Suite User Guide*.
    row_level_permission_tags: ?[]const SessionTag,

    pub const json_field_names = .{
        .row_level_permission_tags = "RowLevelPermissionTags",
    };
};
