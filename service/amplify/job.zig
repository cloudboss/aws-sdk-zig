const Step = @import("step.zig").Step;
const JobSummary = @import("job_summary.zig").JobSummary;

/// Describes an execution job for an Amplify app.
pub const Job = struct {
    /// The execution steps for an execution job, for an Amplify app.
    steps: []const Step,

    /// Describes the summary for an execution job for an Amplify app.
    summary: JobSummary,

    pub const json_field_names = .{
        .steps = "steps",
        .summary = "summary",
    };
};
