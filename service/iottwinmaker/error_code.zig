pub const ErrorCode = enum {
    validation_error,
    internal_failure,
    sync_initializing_error,
    sync_creating_error,
    sync_processing_error,
    sync_deleting_error,
    processing_error,
    composite_component_failure,

    pub const json_field_names = .{
        .validation_error = "VALIDATION_ERROR",
        .internal_failure = "INTERNAL_FAILURE",
        .sync_initializing_error = "SYNC_INITIALIZING_ERROR",
        .sync_creating_error = "SYNC_CREATING_ERROR",
        .sync_processing_error = "SYNC_PROCESSING_ERROR",
        .sync_deleting_error = "SYNC_DELETING_ERROR",
        .processing_error = "PROCESSING_ERROR",
        .composite_component_failure = "COMPOSITE_COMPONENT_FAILURE",
    };
};
