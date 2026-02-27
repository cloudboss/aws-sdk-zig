const Tag = @import("tag.zig").Tag;

/// The parameters that you can use to configure a [scheduled
/// action](https://docs.aws.amazon.com/redshift-serverless/latest/APIReference/API_CreateScheduledAction.html) to create a snapshot. For more information about creating a scheduled action, see [CreateScheduledAction](https://docs.aws.amazon.com/redshift-serverless/latest/APIReference/API_CreateScheduledAction.html).
pub const CreateSnapshotScheduleActionParameters = struct {
    /// The name of the namespace for which you want to configure a scheduled action
    /// to create a snapshot.
    namespace_name: []const u8,

    /// The retention period of the snapshot created by the scheduled action.
    retention_period: ?i32,

    /// A string prefix that is attached to the name of the snapshot created by the
    /// scheduled action. The final name of the snapshot is the string prefix
    /// appended by the date and time of when the snapshot was created.
    snapshot_name_prefix: []const u8,

    /// An array of [Tag
    /// objects](https://docs.aws.amazon.com/redshift-serverless/latest/APIReference/API_Tag.html) to associate with the snapshot.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .namespace_name = "namespaceName",
        .retention_period = "retentionPeriod",
        .snapshot_name_prefix = "snapshotNamePrefix",
        .tags = "tags",
    };
};
