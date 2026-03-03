/// Lifecycle last Cutover initiated.
pub const LifeCycleLastCutoverInitiated = struct {
    api_call_date_time: ?[]const u8 = null,

    /// Lifecycle last Cutover initiated by Job ID.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
        .job_id = "jobID",
    };
};
