const DataIntegrationEventDatasetLoadStatus = @import("data_integration_event_dataset_load_status.zig").DataIntegrationEventDatasetLoadStatus;

/// The target dataset load execution details.
pub const DataIntegrationEventDatasetLoadExecutionDetails = struct {
    /// The failure message (if any) of failed event load execution to dataset.
    message: ?[]const u8 = null,

    /// The event load execution status to target dataset.
    status: DataIntegrationEventDatasetLoadStatus,

    pub const json_field_names = .{
        .message = "message",
        .status = "status",
    };
};
