const OperationFilter = @import("operation_filter.zig").OperationFilter;

pub const ListOperationsRequest = struct {
    /// A complex type that contains specifications for the operations that you want
    /// to list, for
    /// example, operations that you started between a specified start date and end
    /// date.
    ///
    /// If you specify more than one filter, an operation must match all filters to
    /// be returned by
    /// `ListOperations`.
    filters: ?[]const OperationFilter,

    /// The maximum number of items that you want Cloud Map to return in the
    /// response to a
    /// `ListOperations` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 operations.
    max_results: ?i32,

    /// For the first `ListOperations` request, omit this value.
    ///
    /// If the response contains `NextToken`, submit another `ListOperations`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` operations and then filters them based on the
    /// specified criteria. It's possible that no operations in the first
    /// `MaxResults`
    /// operations matched the specified criteria but that subsequent groups of
    /// `MaxResults`
    /// operations do contain operations that match the criteria.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
