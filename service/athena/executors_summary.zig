const ExecutorState = @import("executor_state.zig").ExecutorState;
const ExecutorType = @import("executor_type.zig").ExecutorType;

/// Contains summary information about an executor.
pub const ExecutorsSummary = struct {
    /// The UUID of the executor.
    executor_id: []const u8,

    /// The smallest unit of compute that a session can request from Athena. Size
    /// is measured in data processing unit (DPU) values, a relative measure of
    /// processing
    /// power.
    executor_size: ?i64 = null,

    /// The processing state of the executor. A description of each state follows.
    ///
    /// `CREATING` - The executor is being started, including acquiring
    /// resources.
    ///
    /// `CREATED` - The executor has been started.
    ///
    /// `REGISTERED` - The executor has been registered.
    ///
    /// `TERMINATING` - The executor is in the process of shutting down.
    ///
    /// `TERMINATED` - The executor is no longer running.
    ///
    /// `FAILED` - Due to a failure, the executor is no longer running.
    executor_state: ?ExecutorState = null,

    /// The type of executor used for the application (`COORDINATOR`,
    /// `GATEWAY`, or `WORKER`).
    executor_type: ?ExecutorType = null,

    /// The date and time that the executor started.
    start_date_time: ?i64 = null,

    /// The date and time that the executor was terminated.
    termination_date_time: ?i64 = null,

    pub const json_field_names = .{
        .executor_id = "ExecutorId",
        .executor_size = "ExecutorSize",
        .executor_state = "ExecutorState",
        .executor_type = "ExecutorType",
        .start_date_time = "StartDateTime",
        .termination_date_time = "TerminationDateTime",
    };
};
