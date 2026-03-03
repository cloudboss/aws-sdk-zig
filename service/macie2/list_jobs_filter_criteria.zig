const ListJobsFilterTerm = @import("list_jobs_filter_term.zig").ListJobsFilterTerm;

/// Specifies criteria for filtering the results of a request for information
/// about classification jobs.
pub const ListJobsFilterCriteria = struct {
    /// An array of objects, one for each condition that determines which jobs to
    /// exclude from the results.
    excludes: ?[]const ListJobsFilterTerm = null,

    /// An array of objects, one for each condition that determines which jobs to
    /// include in the results.
    includes: ?[]const ListJobsFilterTerm = null,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
