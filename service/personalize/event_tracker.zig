/// Provides information about an event tracker.
pub const EventTracker = struct {
    /// The Amazon Web Services account that owns the event tracker.
    account_id: ?[]const u8 = null,

    /// The date and time (in Unix format) that the event tracker was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset group that receives the event
    /// data.
    dataset_group_arn: ?[]const u8 = null,

    /// The ARN of the event tracker.
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

    /// The ID of the event tracker. Include this ID in requests to the
    /// [PutEvents](https://docs.aws.amazon.com/personalize/latest/dg/API_UBS_PutEvents.html) API.
    tracking_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .event_tracker_arn = "eventTrackerArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
        .tracking_id = "trackingId",
    };
};
