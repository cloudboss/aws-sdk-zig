const TriggeringDataset = @import("triggering_dataset.zig").TriggeringDataset;
const Schedule = @import("schedule.zig").Schedule;

/// The `DatasetTrigger` that specifies when the dataset is automatically
/// updated.
pub const DatasetTrigger = struct {
    /// The dataset whose content creation triggers the creation of this dataset's
    /// contents.
    dataset: ?TriggeringDataset = null,

    /// The Schedule when the trigger is initiated.
    schedule: ?Schedule = null,

    pub const json_field_names = .{
        .dataset = "dataset",
        .schedule = "schedule",
    };
};
