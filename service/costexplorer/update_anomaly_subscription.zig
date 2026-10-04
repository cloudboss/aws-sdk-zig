const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnomalySubscriptionFrequency = @import("anomaly_subscription_frequency.zig").AnomalySubscriptionFrequency;
const Subscriber = @import("subscriber.zig").Subscriber;
const Expression = @import("expression.zig").Expression;

pub const UpdateAnomalySubscriptionInput = struct {
    /// The update to the frequency value that subscribers receive notifications.
    frequency: ?AnomalySubscriptionFrequency = null,

    /// A list of cost anomaly monitor ARNs.
    monitor_arn_list: ?[]const []const u8 = null,

    /// The update to the subscriber list.
    subscribers: ?[]const Subscriber = null,

    /// A cost anomaly subscription Amazon Resource Name (ARN).
    subscription_arn: []const u8,

    /// The new name of the subscription.
    subscription_name: ?[]const u8 = null,

    /// (deprecated)
    ///
    /// The update to the threshold value for receiving notifications.
    ///
    /// This field has been deprecated. To update a threshold, use
    /// ThresholdExpression. Continued
    /// use of Threshold will be treated as shorthand syntax for a
    /// ThresholdExpression.
    ///
    /// You can specify either Threshold or ThresholdExpression, but not both.
    threshold: ?f64 = null,

    /// The update to the
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// used to specify the anomalies that you want to generate alerts for. This
    /// supports dimensions
    /// and nested expressions. The supported dimensions are
    /// `ANOMALY_TOTAL_IMPACT_ABSOLUTE` and `ANOMALY_TOTAL_IMPACT_PERCENTAGE`,
    /// corresponding to an anomaly’s TotalImpact and TotalImpactPercentage,
    /// respectively (see
    /// [Impact](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Impact.html) for more details). The supported nested expression types are
    /// `AND` and `OR`. The match option `GREATER_THAN_OR_EQUAL` is
    /// required. Values must be numbers between 0 and 10,000,000,000 in string
    /// format.
    ///
    /// You can specify either Threshold or ThresholdExpression, but not both.
    ///
    /// The following are examples of valid ThresholdExpressions:
    ///
    /// * Absolute threshold: `{ "Dimensions": { "Key":
    ///   "ANOMALY_TOTAL_IMPACT_ABSOLUTE",
    /// "MatchOptions": [ "GREATER_THAN_OR_EQUAL" ], "Values": [ "100" ] } }`
    ///
    /// * Percentage threshold: `{ "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_PERCENTAGE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ],
    /// "Values": [ "100" ] } }`
    ///
    /// * `AND` two thresholds together: `{ "And": [ { "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_ABSOLUTE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values":
    /// [ "100" ] } }, { "Dimensions": { "Key": "ANOMALY_TOTAL_IMPACT_PERCENTAGE",
    /// "MatchOptions": [ "GREATER_THAN_OR_EQUAL" ], "Values": [ "100" ] } } ] }`
    ///
    /// * `OR` two thresholds together: `{ "Or": [ { "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_ABSOLUTE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values":
    /// [ "100" ] } }, { "Dimensions": { "Key": "ANOMALY_TOTAL_IMPACT_PERCENTAGE",
    /// "MatchOptions": [ "GREATER_THAN_OR_EQUAL" ], "Values": [ "100" ] } } ] }`
    threshold_expression: ?Expression = null,

    pub const json_field_names = .{
        .frequency = "Frequency",
        .monitor_arn_list = "MonitorArnList",
        .subscribers = "Subscribers",
        .subscription_arn = "SubscriptionArn",
        .subscription_name = "SubscriptionName",
        .threshold = "Threshold",
        .threshold_expression = "ThresholdExpression",
    };
};

pub const UpdateAnomalySubscriptionOutput = struct {
    /// A cost anomaly subscription ARN.
    subscription_arn: []const u8,

    pub const json_field_names = .{
        .subscription_arn = "SubscriptionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnomalySubscriptionInput, options: CallOptions) !UpdateAnomalySubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnomalySubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.UpdateAnomalySubscription");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnomalySubscriptionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAnomalySubscriptionOutput, body, allocator);
}
