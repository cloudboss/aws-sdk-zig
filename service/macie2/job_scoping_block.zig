const JobScopeTerm = @import("job_scope_term.zig").JobScopeTerm;

/// Specifies one or more property- and tag-based conditions that define
/// criteria for including or excluding S3 objects from a classification job.
pub const JobScopingBlock = struct {
    /// An array of conditions, one for each property- or tag-based condition that
    /// determines which objects to include or exclude from the job. If you specify
    /// more than one condition, Amazon Macie uses AND logic to join the conditions.
    @"and": ?[]const JobScopeTerm = null,

    pub const json_field_names = .{
        .@"and" = "and",
    };
};
