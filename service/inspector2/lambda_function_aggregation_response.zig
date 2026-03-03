const aws = @import("aws");

const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of an Amazon Web Services Lambda
/// function finding
/// aggregation.
pub const LambdaFunctionAggregationResponse = struct {
    /// The ID of the Amazon Web Services account that owns the Amazon Web Services
    /// Lambda
    /// function.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services Lambda function names included in the aggregation
    /// results.
    function_name: ?[]const u8 = null,

    /// The tags included in the aggregation results.
    lambda_tags: ?[]const aws.map.StringMapEntry = null,

    /// The date that the Amazon Web Services Lambda function included in the
    /// aggregation results
    /// was last changed.
    last_modified_at: ?i64 = null,

    /// The resource IDs included in the aggregation results.
    resource_id: []const u8,

    /// The runtimes included in the aggregation results.
    runtime: ?[]const u8 = null,

    /// An object that contains the counts of aggregated finding per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .function_name = "functionName",
        .lambda_tags = "lambdaTags",
        .last_modified_at = "lastModifiedAt",
        .resource_id = "resourceId",
        .runtime = "runtime",
        .severity_counts = "severityCounts",
    };
};
