const ResourceQuery = @import("resource_query.zig").ResourceQuery;
const TagSyncTaskStatus = @import("tag_sync_task_status.zig").TagSyncTaskStatus;

/// The Amazon resource name (ARN) of the tag-sync task.
pub const TagSyncTaskItem = struct {
    /// The timestamp of when the tag-sync task was created.
    created_at: ?i64,

    /// The specific error message in cases where the tag-sync task status
    /// is `Error`.
    error_message: ?[]const u8,

    /// The Amazon resource name (ARN) of the application group.
    group_arn: ?[]const u8,

    /// The name of the application group.
    group_name: ?[]const u8,

    resource_query: ?ResourceQuery,

    /// The Amazon resource name (ARN) of the role assumed by the service to tag and
    /// untag resources on your behalf.
    role_arn: ?[]const u8,

    /// The status of the tag-sync task.
    ///
    /// Valid values include:
    ///
    /// * `ACTIVE` - The tag-sync task is actively managing resources in
    /// the application by adding or removing the `awsApplication` tag from
    /// resources
    /// when they are tagged or untagged with the specified tag key-value pair.
    ///
    /// * `ERROR` - The tag-sync task is not actively managing resources
    /// in the application. Review the `ErrorMessage` for more information about
    /// resolving the error.
    status: ?TagSyncTaskStatus,

    /// The tag key.
    tag_key: ?[]const u8,

    /// The tag value.
    tag_value: ?[]const u8,

    /// The Amazon resource name (ARN) of the tag-sync task.
    task_arn: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .error_message = "ErrorMessage",
        .group_arn = "GroupArn",
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .status = "Status",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
        .task_arn = "TaskArn",
    };
};
