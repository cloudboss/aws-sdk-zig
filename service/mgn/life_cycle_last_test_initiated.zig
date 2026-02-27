/// Lifecycle last Test initiated.
pub const LifeCycleLastTestInitiated = struct {
    /// Lifecycle last Test initiated API call date and time.
    api_call_date_time: ?[]const u8,

    /// Lifecycle last Test initiated Job ID.
    job_id: ?[]const u8,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
        .job_id = "jobID",
    };
};
