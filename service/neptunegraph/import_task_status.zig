pub const ImportTaskStatus = enum {
    initializing,
    exporting,
    analyzing_data,
    importing,
    reprovisioning,
    rolling_back,
    succeeded,
    failed,
    cancelling,
    cancelled,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .exporting = "EXPORTING",
        .analyzing_data = "ANALYZING_DATA",
        .importing = "IMPORTING",
        .reprovisioning = "REPROVISIONING",
        .rolling_back = "ROLLING_BACK",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .deleted = "DELETED",
    };
};
