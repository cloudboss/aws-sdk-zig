const MetricType = @import("metric_type.zig").MetricType;

pub const ListMetricsRequest = struct {
    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The type of metrics to list. Valid values: `AWS_MANAGED` |
    /// `CUSTOMER_MANAGED`.
    @"type": ?MetricType = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .@"type" = "Type",
    };
};
