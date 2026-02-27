pub const JobStatus = enum {
    not_yet_run,
    successful,
    failed,
    disabled,

    pub const json_field_names = .{
        .not_yet_run = "NOT_YET_RUN",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .disabled = "DISABLED",
    };
};
