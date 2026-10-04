const DatasetItem = @import("dataset_item.zig").DatasetItem;
const TimeseriesItem = @import("timeseries_item.zig").TimeseriesItem;

/// Input source for processing. Specify exactly one option.
pub const ProcessingInput = union(enum) {
    /// A dataset containing multiple items to process.
    dataset: ?DatasetItem,
    /// List of individual timeseries items to process.
    timeseries: ?[]const TimeseriesItem,

    pub const json_field_names = .{
        .dataset = "dataset",
        .timeseries = "timeseries",
    };
};
