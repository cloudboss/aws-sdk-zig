const JobComparator = @import("job_comparator.zig").JobComparator;
const ListJobsFilterKey = @import("list_jobs_filter_key.zig").ListJobsFilterKey;

/// Specifies a condition that filters the results of a request for information
/// about classification jobs. Each condition consists of a property, an
/// operator, and one or more values.
pub const ListJobsFilterTerm = struct {
    /// The operator to use to filter the results.
    comparator: ?JobComparator,

    /// The property to use to filter the results.
    key: ?ListJobsFilterKey,

    /// An array that lists one or more values to use to filter the results.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .values = "values",
    };
};
