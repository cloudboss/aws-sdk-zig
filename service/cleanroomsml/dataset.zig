const DatasetInputConfig = @import("dataset_input_config.zig").DatasetInputConfig;
const DatasetType = @import("dataset_type.zig").DatasetType;

/// Defines where the training dataset is located, what type of data it
/// contains, and how to access the data.
pub const Dataset = struct {
    /// A DatasetInputConfig object that defines the data source and schema mapping.
    input_config: DatasetInputConfig,

    /// What type of information is found in the dataset.
    type: DatasetType,

    pub const json_field_names = .{
        .input_config = "inputConfig",
        .type = "type",
    };
};
