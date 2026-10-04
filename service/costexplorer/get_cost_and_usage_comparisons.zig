const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DateInterval = @import("date_interval.zig").DateInterval;
const Expression = @import("expression.zig").Expression;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const CostAndUsageComparison = @import("cost_and_usage_comparison.zig").CostAndUsageComparison;
const ComparisonMetricValue = @import("comparison_metric_value.zig").ComparisonMetricValue;

pub const GetCostAndUsageComparisonsInput = struct {
    /// The reference time period for comparison. This time period serves as the
    /// baseline against
    /// which other cost and usage data will be compared. The interval must start
    /// and end on the first
    /// day of a month, with a duration of exactly one month.
    baseline_time_period: DateInterval,

    /// The Amazon Resource Name (ARN) that uniquely identifies a specific billing
    /// view. The ARN
    /// is used to specify which particular billing view you want to interact with
    /// or retrieve
    /// information from when making API calls related to Amazon Web Services
    /// Billing and Cost
    /// Management features. The BillingViewArn can be retrieved by calling the
    /// ListBillingViews
    /// API.
    billing_view_arn: ?[]const u8 = null,

    /// The comparison time period for analysis. This time period's cost and usage
    /// data will be
    /// compared against the baseline time period. The interval must start and end
    /// on the first day of
    /// a month, with a duration of exactly one month.
    comparison_time_period: DateInterval,

    filter: ?Expression = null,

    /// You can group results using the attributes `DIMENSION`, `TAG`, and
    /// `COST_CATEGORY`.
    group_by: ?[]const GroupDefinition = null,

    /// The maximum number of results that are returned for the request.
    max_results: ?i32 = null,

    /// The cost and usage metric to compare. Valid values are `AmortizedCost`,
    /// `BlendedCost`, `NetAmortizedCost`, `NetUnblendedCost`,
    /// `NormalizedUsageAmount`, `UnblendedCost`, and
    /// `UsageQuantity`.
    metric_for_comparison: []const u8,

    /// The token to retrieve the next set of paginated results.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_time_period = "BaselineTimePeriod",
        .billing_view_arn = "BillingViewArn",
        .comparison_time_period = "ComparisonTimePeriod",
        .filter = "Filter",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .metric_for_comparison = "MetricForComparison",
        .next_page_token = "NextPageToken",
    };
};

pub const GetCostAndUsageComparisonsOutput = struct {
    /// An array of comparison results showing cost and usage metrics between
    /// `BaselineTimePeriod` and `ComparisonTimePeriod`.
    cost_and_usage_comparisons: ?[]const CostAndUsageComparison = null,

    /// The token to retrieve the next set of paginated results.
    next_page_token: ?[]const u8 = null,

    /// A summary of the total cost and usage, comparing amounts between
    /// `BaselineTimePeriod` and `ComparisonTimePeriod` and their differences.
    /// This total represents the aggregate total across all paginated results, if
    /// the response spans
    /// multiple pages.
    total_cost_and_usage: ?[]const aws.map.MapEntry(ComparisonMetricValue) = null,

    pub const json_field_names = .{
        .cost_and_usage_comparisons = "CostAndUsageComparisons",
        .next_page_token = "NextPageToken",
        .total_cost_and_usage = "TotalCostAndUsage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostAndUsageComparisonsInput, options: CallOptions) !GetCostAndUsageComparisonsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostAndUsageComparisonsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCostAndUsageComparisons");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostAndUsageComparisonsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCostAndUsageComparisonsOutput, body, allocator);
}
