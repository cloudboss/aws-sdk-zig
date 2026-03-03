/// Contains the details of a message movement task.
pub const ListMessageMoveTasksResultEntry = struct {
    /// The approximate number of messages already moved to the destination queue.
    approximate_number_of_messages_moved: i64 = 0,

    /// The number of messages to be moved from the source queue. This number is
    /// obtained at
    /// the time of starting the message movement task and is only included after
    /// the message
    /// movement task is selected to start.
    approximate_number_of_messages_to_move: ?i64 = null,

    /// The ARN of the destination queue if it has been specified in the
    /// `StartMessageMoveTask` request. If a `DestinationArn` has not
    /// been specified in the `StartMessageMoveTask` request, this field value will
    /// be NULL.
    destination_arn: ?[]const u8 = null,

    /// The task failure reason (only included if the task status is FAILED).
    failure_reason: ?[]const u8 = null,

    /// The number of messages to be moved per second (the message movement rate),
    /// if it has
    /// been specified in the `StartMessageMoveTask` request. If a
    /// `MaxNumberOfMessagesPerSecond` has not been specified in the
    /// `StartMessageMoveTask` request, this field value will be NULL.
    max_number_of_messages_per_second: ?i32 = null,

    /// The ARN of the queue that contains the messages to be moved to another
    /// queue.
    source_arn: ?[]const u8 = null,

    /// The timestamp of starting the message movement task.
    started_timestamp: i64 = 0,

    /// The status of the message movement task. Possible values are: RUNNING,
    /// COMPLETED,
    /// CANCELLING, CANCELLED, and FAILED.
    status: ?[]const u8 = null,

    /// An identifier associated with a message movement task. When this field is
    /// returned in
    /// the response of the `ListMessageMoveTasks` action, it is only populated for
    /// tasks that are in RUNNING status.
    task_handle: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_number_of_messages_moved = "ApproximateNumberOfMessagesMoved",
        .approximate_number_of_messages_to_move = "ApproximateNumberOfMessagesToMove",
        .destination_arn = "DestinationArn",
        .failure_reason = "FailureReason",
        .max_number_of_messages_per_second = "MaxNumberOfMessagesPerSecond",
        .source_arn = "SourceArn",
        .started_timestamp = "StartedTimestamp",
        .status = "Status",
        .task_handle = "TaskHandle",
    };
};
