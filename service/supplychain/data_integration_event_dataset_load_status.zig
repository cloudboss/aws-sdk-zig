pub const DataIntegrationEventDatasetLoadStatus = enum {
    succeeded,
    in_progress,
    failed,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
