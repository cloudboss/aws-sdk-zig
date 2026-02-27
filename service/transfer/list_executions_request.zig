pub const ListExecutionsRequest = struct {
    /// The maximum number of items to return.
    max_results: ?i32,

    /// `ListExecutions` returns the `NextToken` parameter in the output. You can
    /// then pass the `NextToken` parameter in a subsequent command to continue
    /// listing additional executions.
    ///
    /// This is useful for pagination, for instance. If you have 100 executions for
    /// a workflow, you might only want to list first 10. If so, call the API by
    /// specifying the `max-results`:
    ///
    /// `aws transfer list-executions --max-results 10`
    ///
    /// This returns details for the first 10 executions, as well as the pointer
    /// (`NextToken`) to the eleventh execution. You can now call the API again,
    /// supplying the `NextToken` value you received:
    ///
    /// `aws transfer list-executions --max-results 10 --next-token
    /// $somePointerReturnedFromPreviousListResult`
    ///
    /// This call returns the next 10 executions, the 11th through the 20th. You can
    /// then repeat the call until the details for all 100 executions have been
    /// returned.
    next_token: ?[]const u8,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
    };
};
