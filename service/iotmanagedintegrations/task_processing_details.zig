/// Details about the over-the-air (OTA) task process.
pub const TaskProcessingDetails = struct {
    /// The number of canceled things in an over-the-air (OTA) task.
    number_of_canceled_things: ?i32,

    /// The number of failed things in an over-the-air (OTA) task.
    number_of_failed_things: ?i32,

    /// The number of in progress things in an over-the-air (OTA) task.
    number_of_in_progress_things: ?i32,

    /// The number of queued things in an over-the-air (OTA) task.
    number_of_queued_things: ?i32,

    /// The number of rejected things in an over-the-air (OTA) task.
    number_of_rejected_things: ?i32,

    /// The number of removed things in an over-the-air (OTA) task.
    number_of_removed_things: ?i32,

    /// The number of succeeded things in an over-the-air (OTA) task.
    number_of_succeeded_things: ?i32,

    /// The number of timed out things in an over-the-air (OTA) task.
    number_of_timed_out_things: ?i32,

    /// The targets of the over-the-air (OTA) task.
    processing_targets: ?[]const []const u8,

    pub const json_field_names = .{
        .number_of_canceled_things = "NumberOfCanceledThings",
        .number_of_failed_things = "NumberOfFailedThings",
        .number_of_in_progress_things = "NumberOfInProgressThings",
        .number_of_queued_things = "numberOfQueuedThings",
        .number_of_rejected_things = "numberOfRejectedThings",
        .number_of_removed_things = "numberOfRemovedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
        .number_of_timed_out_things = "numberOfTimedOutThings",
        .processing_targets = "processingTargets",
    };
};
