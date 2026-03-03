const DataIntegrationFlowDatasetSourceConfiguration = @import("data_integration_flow_dataset_source_configuration.zig").DataIntegrationFlowDatasetSourceConfiguration;
const DataIntegrationFlowS3SourceConfiguration = @import("data_integration_flow_s3_source_configuration.zig").DataIntegrationFlowS3SourceConfiguration;
const DataIntegrationFlowSourceType = @import("data_integration_flow_source_type.zig").DataIntegrationFlowSourceType;

/// The DataIntegrationFlow source parameters.
pub const DataIntegrationFlowSource = struct {
    /// The dataset DataIntegrationFlow source.
    dataset_source: ?DataIntegrationFlowDatasetSourceConfiguration = null,

    /// The S3 DataIntegrationFlow source.
    s_3_source: ?DataIntegrationFlowS3SourceConfiguration = null,

    /// The DataIntegrationFlow source name that can be used as table alias in SQL
    /// transformation query.
    source_name: []const u8,

    /// The DataIntegrationFlow source type.
    source_type: DataIntegrationFlowSourceType,

    pub const json_field_names = .{
        .dataset_source = "datasetSource",
        .s_3_source = "s3Source",
        .source_name = "sourceName",
        .source_type = "sourceType",
    };
};
