const Job = @import("job.zig").Job;

pub const GetJobResponse = struct {
    /// The requested job definition.
    job: ?Job = null,

    pub const json_field_names = .{
        .job = "Job",
    };
};
