const ForEachSelectorResult = @import("for_each_selector_result.zig").ForEachSelectorResult;
const ForEachStatus = @import("for_each_status.zig").ForEachStatus;

/// The status, the iteration-step counts, and the selector information for a
/// ForEach step execution.
pub const ForEachStepMetadata = struct {
    /// The number of iteration steps that failed.
    failed_step_count: ?i32 = null,

    /// The number of input items that the ForEach step iterates over.
    input_item_count: ?i32 = null,

    /// Identifies the body step and iteration selected within the ForEach step.
    selector: ?ForEachSelectorResult = null,

    /// The status of the ForEach step execution.
    status: ?ForEachStatus = null,

    /// The number of iteration steps that were stopped.
    stopped_step_count: ?i32 = null,

    /// The number of iteration steps that completed successfully.
    succeeded_step_count: ?i32 = null,

    /// The total number of steps generated across all iterations of the ForEach
    /// step.
    total_step_count: ?i32 = null,

    pub const json_field_names = .{
        .failed_step_count = "FailedStepCount",
        .input_item_count = "InputItemCount",
        .selector = "Selector",
        .status = "Status",
        .stopped_step_count = "StoppedStepCount",
        .succeeded_step_count = "SucceededStepCount",
        .total_step_count = "TotalStepCount",
    };
};
