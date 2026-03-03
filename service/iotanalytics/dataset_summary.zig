const DatasetActionSummary = @import("dataset_action_summary.zig").DatasetActionSummary;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;
const DatasetTrigger = @import("dataset_trigger.zig").DatasetTrigger;

/// A summary of information about a dataset.
pub const DatasetSummary = struct {
    /// A list of `DataActionSummary` objects.
    actions: ?[]const DatasetActionSummary = null,

    /// The time the dataset was created.
    creation_time: ?i64 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// The last time the dataset was updated.
    last_update_time: ?i64 = null,

    /// The status of the dataset.
    status: ?DatasetStatus = null,

    /// A list of triggers. A trigger causes dataset content to be populated at a
    /// specified time
    /// interval or when another dataset is populated. The list of triggers can be
    /// empty or contain up
    /// to five `DataSetTrigger` objects
    triggers: ?[]const DatasetTrigger = null,

    pub const json_field_names = .{
        .actions = "actions",
        .creation_time = "creationTime",
        .dataset_name = "datasetName",
        .last_update_time = "lastUpdateTime",
        .status = "status",
        .triggers = "triggers",
    };
};
