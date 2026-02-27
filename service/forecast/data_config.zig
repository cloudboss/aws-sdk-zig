const AdditionalDataset = @import("additional_dataset.zig").AdditionalDataset;
const AttributeConfig = @import("attribute_config.zig").AttributeConfig;

/// The data configuration for your dataset group and any additional datasets.
pub const DataConfig = struct {
    /// Additional built-in datasets like Holidays and the Weather Index.
    additional_datasets: ?[]const AdditionalDataset,

    /// Aggregation and filling options for attributes in your dataset group.
    attribute_configs: ?[]const AttributeConfig,

    /// The ARN of the dataset group used to train the predictor.
    dataset_group_arn: []const u8,

    pub const json_field_names = .{
        .additional_datasets = "AdditionalDatasets",
        .attribute_configs = "AttributeConfigs",
        .dataset_group_arn = "DatasetGroupArn",
    };
};
