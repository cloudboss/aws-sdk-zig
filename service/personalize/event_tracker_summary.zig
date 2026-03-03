/// Provides a summary of the properties of an event tracker. For a complete
/// listing, call the
/// [DescribeEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeEventTracker.html) API.
pub const EventTrackerSummary = struct {
    /// The date and time (in Unix time) that the event tracker was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the event tracker.
    event_tracker_arn: ?[]const u8 = null,

    /// The date and time (in Unix time) that the event tracker was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the event tracker.
    name: ?[]const u8 = null,

    /// The status of the event tracker.
    ///
    /// An event tracker can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .event_tracker_arn = "eventTrackerArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};
