const NotebookS3LocationForOutput = @import("notebook_s3_location_for_output.zig").NotebookS3LocationForOutput;
const NotebookExecutionStatus = @import("notebook_execution_status.zig").NotebookExecutionStatus;

/// Details for a notebook execution. The details include information such as
/// the unique ID
/// and status of the notebook execution.
pub const NotebookExecutionSummary = struct {
    /// The unique identifier of the editor associated with the notebook execution.
    editor_id: ?[]const u8 = null,

    /// The timestamp when notebook execution started.
    end_time: ?i64 = null,

    /// The unique ID of the execution engine for the notebook execution.
    execution_engine_id: ?[]const u8 = null,

    /// The unique identifier of the notebook execution.
    notebook_execution_id: ?[]const u8 = null,

    /// The name of the notebook execution.
    notebook_execution_name: ?[]const u8 = null,

    /// The Amazon S3 location that stores the notebook execution input.
    notebook_s3_location: ?NotebookS3LocationForOutput = null,

    /// The timestamp when notebook execution started.
    start_time: ?i64 = null,

    /// The status of the notebook execution.
    ///
    /// * `START_PENDING` indicates that the cluster has received the execution
    /// request but execution has not begun.
    ///
    /// * `STARTING` indicates that the execution is starting on the
    /// cluster.
    ///
    /// * `RUNNING` indicates that the execution is being processed by the
    /// cluster.
    ///
    /// * `FINISHING` indicates that execution processing is in the final
    /// stages.
    ///
    /// * `FINISHED` indicates that the execution has completed without
    /// error.
    ///
    /// * `FAILING` indicates that the execution is failing and will not finish
    /// successfully.
    ///
    /// * `FAILED` indicates that the execution failed.
    ///
    /// * `STOP_PENDING` indicates that the cluster has received a
    /// `StopNotebookExecution` request and the stop is pending.
    ///
    /// * `STOPPING` indicates that the cluster is in the process of stopping the
    /// execution as a result of a `StopNotebookExecution` request.
    ///
    /// * `STOPPED` indicates that the execution stopped because of a
    /// `StopNotebookExecution` request.
    status: ?NotebookExecutionStatus = null,

    pub const json_field_names = .{
        .editor_id = "EditorId",
        .end_time = "EndTime",
        .execution_engine_id = "ExecutionEngineId",
        .notebook_execution_id = "NotebookExecutionId",
        .notebook_execution_name = "NotebookExecutionName",
        .notebook_s3_location = "NotebookS3Location",
        .start_time = "StartTime",
        .status = "Status",
    };
};
