const SearchJobsFilterOperator = @import("search_jobs_filter_operator.zig").SearchJobsFilterOperator;

/// A filter used to search for Amazon Braket hybrid jobs.
pub const SearchJobsFilter = struct {
    /// The name of the hybrid job parameter to filter based on. Filter name can be
    /// either `jobArn` or `createdAt`.
    name: []const u8,

    /// An operator to use for the filter.
    operator: SearchJobsFilterOperator,

    /// The values used to filter hybrid jobs based on the filter name and operator.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
