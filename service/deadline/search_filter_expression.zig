const DateTimeFilterExpression = @import("date_time_filter_expression.zig").DateTimeFilterExpression;
const SearchGroupedFilterExpressions = @import("search_grouped_filter_expressions.zig").SearchGroupedFilterExpressions;
const ParameterFilterExpression = @import("parameter_filter_expression.zig").ParameterFilterExpression;
const SearchTermFilterExpression = @import("search_term_filter_expression.zig").SearchTermFilterExpression;
const StringFilterExpression = @import("string_filter_expression.zig").StringFilterExpression;
const StringListFilterExpression = @import("string_list_filter_expression.zig").StringListFilterExpression;

/// The type of search filter to apply.
pub const SearchFilterExpression = union(enum) {
    /// Filters based on date and time.
    date_time_filter: ?DateTimeFilterExpression,
    /// Filters by group.
    group_filter: ?SearchGroupedFilterExpressions,
    /// Filters by parameter.
    parameter_filter: ?ParameterFilterExpression,
    /// Filters by a specified search term.
    search_term_filter: ?SearchTermFilterExpression,
    /// Filters by a string.
    string_filter: ?StringFilterExpression,
    /// Filters by a list of strings.
    string_list_filter: ?StringListFilterExpression,

    pub const json_field_names = .{
        .date_time_filter = "dateTimeFilter",
        .group_filter = "groupFilter",
        .parameter_filter = "parameterFilter",
        .search_term_filter = "searchTermFilter",
        .string_filter = "stringFilter",
        .string_list_filter = "stringListFilter",
    };
};
