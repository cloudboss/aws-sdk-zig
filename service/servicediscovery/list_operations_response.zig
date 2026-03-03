const OperationSummary = @import("operation_summary.zig").OperationSummary;

pub const ListOperationsResponse = struct {
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
    next_token: ?[]const u8 = null,

    /// Summary information about the operations that match the specified criteria.
    operations: ?[]const OperationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .operations = "Operations",
    };
};
