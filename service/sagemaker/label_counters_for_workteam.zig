/// Provides counts for human-labeled tasks in the labeling job.
pub const LabelCountersForWorkteam = struct {
    /// The total number of data objects labeled by a human worker.
    human_labeled: ?i32 = null,

    /// The total number of data objects that need to be labeled by a human worker.
    pending_human: ?i32 = null,

    /// The total number of tasks in the labeling job.
    total: ?i32 = null,

    pub const json_field_names = .{
        .human_labeled = "HumanLabeled",
        .pending_human = "PendingHuman",
        .total = "Total",
    };
};
