/// Behavior graphs that could not be processed in the request.
pub const UnprocessedGraph = struct {
    /// The ARN of the organization behavior graph.
    graph_arn: ?[]const u8,

    /// The reason data source package information could not be processed for a
    /// behavior
    /// graph.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .graph_arn = "GraphArn",
        .reason = "Reason",
    };
};
