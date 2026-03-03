/// Returns tag-sync tasks filtered by the Amazon resource name (ARN) or name of
/// a
/// specified application group.
pub const ListTagSyncTasksFilter = struct {
    /// The Amazon resource name (ARN) of the application group.
    group_arn: ?[]const u8 = null,

    /// The name of the application group.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_arn = "GroupArn",
        .group_name = "GroupName",
    };
};
