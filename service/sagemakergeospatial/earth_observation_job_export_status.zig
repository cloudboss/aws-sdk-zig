pub const EarthObservationJobExportStatus = enum {
    /// IN_PROGRESS
    in_progress,
    /// SUCCEEDED
    succeeded,
    /// FAILED
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
