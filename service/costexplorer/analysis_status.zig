pub const AnalysisStatus = enum {
    succeeded,
    processing,
    failed,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .processing = "PROCESSING",
        .failed = "FAILED",
    };
};
