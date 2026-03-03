/// Indicates the completion progress for a batch job.
pub const JobProgress = struct {
    /// Shows the completed percentage of enrollment or registration requests listed
    /// in the
    /// input file.
    percent_complete: ?i32 = null,

    pub const json_field_names = .{
        .percent_complete = "PercentComplete",
    };
};
