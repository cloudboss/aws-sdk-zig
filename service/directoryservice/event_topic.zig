const TopicStatus = @import("topic_status.zig").TopicStatus;

/// Information about Amazon SNS topic and Directory Service directory
/// associations.
pub const EventTopic = struct {
    /// The date and time of when you associated your directory with the Amazon SNS
    /// topic.
    created_date_time: ?i64,

    /// The Directory ID of an Directory Service directory that will publish status
    /// messages to an Amazon SNS
    /// topic.
    directory_id: ?[]const u8,

    /// The topic registration status.
    status: ?TopicStatus,

    /// The Amazon SNS topic ARN (Amazon Resource Name).
    topic_arn: ?[]const u8,

    /// The name of an Amazon SNS topic the receives status messages from the
    /// directory.
    topic_name: ?[]const u8,

    pub const json_field_names = .{
        .created_date_time = "CreatedDateTime",
        .directory_id = "DirectoryId",
        .status = "Status",
        .topic_arn = "TopicArn",
        .topic_name = "TopicName",
    };
};
