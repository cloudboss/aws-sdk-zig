/// The job process details.
pub const JobProcessDetails = struct {
    /// The number of things that cancelled the job.
    number_of_canceled_things: ?i32 = null,

    /// The number of things that failed executing the job.
    number_of_failed_things: ?i32 = null,

    /// The number of things currently executing the job.
    number_of_in_progress_things: ?i32 = null,

    /// The number of things that are awaiting execution of the job.
    number_of_queued_things: ?i32 = null,

    /// The number of things that rejected the job.
    number_of_rejected_things: ?i32 = null,

    /// The number of things that are no longer scheduled to execute the job because
    /// they
    /// have been deleted or have been removed from the group that was a target of
    /// the
    /// job.
    number_of_removed_things: ?i32 = null,

    /// The number of things which successfully completed the job.
    number_of_succeeded_things: ?i32 = null,

    /// The number of things whose job execution status is `TIMED_OUT`.
    number_of_timed_out_things: ?i32 = null,

    /// The target devices to which the job execution is being rolled out. This
    /// value will
    /// be null after the job execution has finished rolling out to all the target
    /// devices.
    processing_targets: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .number_of_canceled_things = "numberOfCanceledThings",
        .number_of_failed_things = "numberOfFailedThings",
        .number_of_in_progress_things = "numberOfInProgressThings",
        .number_of_queued_things = "numberOfQueuedThings",
        .number_of_rejected_things = "numberOfRejectedThings",
        .number_of_removed_things = "numberOfRemovedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
        .number_of_timed_out_things = "numberOfTimedOutThings",
        .processing_targets = "processingTargets",
    };
};
