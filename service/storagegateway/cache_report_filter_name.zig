pub const CacheReportFilterName = enum {
    upload_state,
    upload_failure_reason,

    pub const json_field_names = .{
        .upload_state = "UploadState",
        .upload_failure_reason = "UploadFailureReason",
    };
};
