const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of an Amazon Web Services Lambda
/// function layer
/// finding aggregation.
pub const LambdaLayerAggregationResponse = struct {
    /// The account ID of the Amazon Web Services Lambda function layer.
    account_id: []const u8,

    /// The names of the Amazon Web Services Lambda functions associated with the
    /// layers.
    function_name: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Lambda function
    /// layer.
    layer_arn: []const u8,

    /// The Resource ID of the Amazon Web Services Lambda function layer.
    resource_id: []const u8,

    /// An object that contains the counts of aggregated finding per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .function_name = "functionName",
        .layer_arn = "layerArn",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
