/// Provides a breakdown of the number of objects labeled.
pub const LabelCounters = struct {
    /// The total number of objects that could not be labeled due to an error.
    failed_non_retryable_error: ?i32 = null,

    /// The total number of objects labeled by a human worker.
    human_labeled: ?i32 = null,

    /// The total number of objects labeled by automated data labeling.
    machine_labeled: ?i32 = null,

    /// The total number of objects labeled.
    total_labeled: ?i32 = null,

    /// The total number of objects not yet labeled.
    unlabeled: ?i32 = null,

    pub const json_field_names = .{
        .failed_non_retryable_error = "FailedNonRetryableError",
        .human_labeled = "HumanLabeled",
        .machine_labeled = "MachineLabeled",
        .total_labeled = "TotalLabeled",
        .unlabeled = "Unlabeled",
    };
};
