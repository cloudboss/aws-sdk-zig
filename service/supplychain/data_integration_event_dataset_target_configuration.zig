const DataIntegrationEventDatasetOperationType = @import("data_integration_event_dataset_operation_type.zig").DataIntegrationEventDatasetOperationType;

/// The target dataset configuration for a DATASET event type.
pub const DataIntegrationEventDatasetTargetConfiguration = struct {
    /// The datalake dataset ARN identifier.
    dataset_identifier: []const u8,

    /// The target dataset load operation type.
    operation_type: DataIntegrationEventDatasetOperationType,

    pub const json_field_names = .{
        .dataset_identifier = "datasetIdentifier",
        .operation_type = "operationType",
    };
};
