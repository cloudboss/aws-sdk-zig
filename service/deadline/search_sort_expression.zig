const FieldSortExpression = @import("field_sort_expression.zig").FieldSortExpression;
const ParameterSortExpression = @import("parameter_sort_expression.zig").ParameterSortExpression;
const UserJobsFirst = @import("user_jobs_first.zig").UserJobsFirst;

/// The resources to search.
pub const SearchSortExpression = union(enum) {
    /// Options for sorting by a field.
    field_sort: ?FieldSortExpression,
    /// Options for sorting by a parameter.
    parameter_sort: ?ParameterSortExpression,
    /// Options for sorting a particular user's jobs first.
    user_jobs_first: ?UserJobsFirst,

    pub const json_field_names = .{
        .field_sort = "fieldSort",
        .parameter_sort = "parameterSort",
        .user_jobs_first = "userJobsFirst",
    };
};
