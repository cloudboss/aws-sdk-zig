const DataIntegrationFlowDatasetOptions = @import("data_integration_flow_dataset_options.zig").DataIntegrationFlowDatasetOptions;

/// The dataset DataIntegrationFlow target configuration parameters.
pub const DataIntegrationFlowDatasetTargetConfiguration = struct {
    /// The dataset ARN.
    dataset_identifier: []const u8,

    /// The dataset DataIntegrationFlow target options.
    options: ?DataIntegrationFlowDatasetOptions = null,

    pub const json_field_names = .{
        .dataset_identifier = "datasetIdentifier",
        .options = "options",
    };
};
