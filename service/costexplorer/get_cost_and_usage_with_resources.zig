const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const DimensionValuesWithAttributes = @import("dimension_values_with_attributes.zig").DimensionValuesWithAttributes;
const ResultByTime = @import("result_by_time.zig").ResultByTime;

pub const GetCostAndUsageWithResourcesInput = struct {
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

    /// Filters Amazon Web Services costs by different dimensions. For example, you
    /// can specify
    /// `SERVICE` and `LINKED_ACCOUNT` and get the costs that are associated
    /// with that account's usage of that service. You can nest `Expression` objects
    /// to
    /// define any combination of dimension filters. For more information, see
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html).
    ///
    /// The `GetCostAndUsageWithResources` operation requires that you either group
    /// by or filter by a `ResourceId`. It requires the
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html)
    /// `"SERVICE = Amazon Elastic Compute Cloud - Compute"` in the filter.
    ///
    /// Valid values for `MatchOptions` for `Dimensions` are
    /// `EQUALS` and `CASE_SENSITIVE`.
    ///
    /// Valid values for `MatchOptions` for `CostCategories` and
    /// `Tags` are `EQUALS`, `ABSENT`, and
    /// `CASE_SENSITIVE`. Default values are `EQUALS` and
    /// `CASE_SENSITIVE`.
    filter: Expression,

    /// Sets the Amazon Web Services cost granularity to `MONTHLY`,
    /// `DAILY`, or `HOURLY`. If `Granularity` isn't set, the
    /// response object doesn't include the `Granularity`, `MONTHLY`,
    /// `DAILY`, or `HOURLY`.
    granularity: Granularity,

    /// You can group Amazon Web Services costs using up to two different groups:
    /// `DIMENSION`, `TAG`, `COST_CATEGORY`.
    group_by: ?[]const GroupDefinition = null,

    /// Which metrics are returned in the query. For more information about blended
    /// and
    /// unblended rates, see [Why does the "blended" annotation
    /// appear on some line items in my
    /// bill?](http://aws.amazon.com/premiumsupport/knowledge-center/blended-rates-intro/).
    ///
    /// Valid values are `AmortizedCost`, `BlendedCost`,
    /// `NetAmortizedCost`, `NetUnblendedCost`,
    /// `NormalizedUsageAmount`, `UnblendedCost`, and
    /// `UsageQuantity`.
    ///
    /// If you return the `UsageQuantity` metric, the service aggregates all usage
    /// numbers without taking the units into account. For example, if you aggregate
    /// `usageQuantity` across all of Amazon EC2, the results aren't meaningful
    /// because
    /// Amazon EC2 compute hours and data transfer are measured in different units
    /// (for example,
    /// hour or GB). To get more meaningful `UsageQuantity` metrics, filter by
    /// `UsageType` or `UsageTypeGroups`.
    ///
    /// `Metrics` is required for `GetCostAndUsageWithResources`
    /// requests.
    metrics: ?[]const []const u8 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// Sets the start and end dates for retrieving Amazon Web Services costs. The
    /// range must
    /// be within the last 14 days (the start date cannot be earlier than 14 days
    /// ago). The start date
    /// is inclusive, but the end date is exclusive. For example, if `start` is
    /// `2017-01-01` and `end` is `2017-05-01`, then the cost and
    /// usage data is retrieved from `2017-01-01` up to and including
    /// `2017-04-30` but not including `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .metrics = "Metrics",
        .next_page_token = "NextPageToken",
        .time_period = "TimePeriod",
    };
};

pub const GetCostAndUsageWithResourcesOutput = struct {
    /// The attributes that apply to a specific dimension value. For example, if the
    /// value is a
    /// linked account, the attribute is that account name.
    dimension_value_attributes: ?[]const DimensionValuesWithAttributes = null,

    /// The groups that are specified by the `Filter` or `GroupBy`
    /// parameters in the request.
    group_definitions: ?[]const GroupDefinition = null,

    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The time period that's covered by the results in the response.
    results_by_time: ?[]const ResultByTime = null,

    pub const json_field_names = .{
        .dimension_value_attributes = "DimensionValueAttributes",
        .group_definitions = "GroupDefinitions",
        .next_page_token = "NextPageToken",
        .results_by_time = "ResultsByTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostAndUsageWithResourcesInput, options: CallOptions) !GetCostAndUsageWithResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostAndUsageWithResourcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCostAndUsageWithResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostAndUsageWithResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCostAndUsageWithResourcesOutput, body, allocator);
}
