pub const BuildBatchPhaseType = enum {
    submitted,
    download_batchspec,
    in_progress,
    combine_artifacts,
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .download_batchspec = "DOWNLOAD_BATCHSPEC",
        .in_progress = "IN_PROGRESS",
        .combine_artifacts = "COMBINE_ARTIFACTS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
