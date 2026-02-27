const DataIntegrationFlowDatasetOptions = @import("data_integration_flow_dataset_options.zig").DataIntegrationFlowDatasetOptions;

/// The dataset DataIntegrationFlow source configuration parameters.
pub const DataIntegrationFlowDatasetSourceConfiguration = struct {
    /// The ARN of the dataset.
    dataset_identifier: []const u8,

    /// The dataset DataIntegrationFlow source options.
    options: ?DataIntegrationFlowDatasetOptions,

    pub const json_field_names = .{
        .dataset_identifier = "datasetIdentifier",
        .options = "options",
    };
};
