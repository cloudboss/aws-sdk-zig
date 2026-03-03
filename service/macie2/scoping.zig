const JobScopingBlock = @import("job_scoping_block.zig").JobScopingBlock;

/// Specifies one or more property- and tag-based conditions that define
/// criteria for including or excluding S3 objects from a classification job.
/// Exclude conditions take precedence over include conditions.
pub const Scoping = struct {
    /// The property- and tag-based conditions that determine which objects to
    /// exclude from the analysis.
    excludes: ?JobScopingBlock = null,

    /// The property- and tag-based conditions that determine which objects to
    /// include in the analysis.
    includes: ?JobScopingBlock = null,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
