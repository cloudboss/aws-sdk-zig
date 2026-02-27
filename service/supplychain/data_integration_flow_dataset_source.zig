/// The details of a flow execution with dataset source.
pub const DataIntegrationFlowDatasetSource = struct {
    /// The ARN of the dataset source.
    dataset_identifier: []const u8,

    pub const json_field_names = .{
        .dataset_identifier = "datasetIdentifier",
    };
};
