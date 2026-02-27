const TopicRefreshStatus = @import("topic_refresh_status.zig").TopicRefreshStatus;

/// The details about the refresh of a topic.
pub const TopicRefreshDetails = struct {
    /// The Amazon Resource Name (ARN) of the topic refresh.
    refresh_arn: ?[]const u8,

    /// The ID of the refresh, which occurs as a result of topic creation or topic
    /// update.
    refresh_id: ?[]const u8,

    /// The status of the refresh job that indicates whether the job is still
    /// running, completed successfully, or failed.
    refresh_status: ?TopicRefreshStatus,

    pub const json_field_names = .{
        .refresh_arn = "RefreshArn",
        .refresh_id = "RefreshId",
        .refresh_status = "RefreshStatus",
    };
};
