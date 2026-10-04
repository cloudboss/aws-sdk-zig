const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const SavingsPlansCoverage = @import("savings_plans_coverage.zig").SavingsPlansCoverage;

pub const GetSavingsPlansCoverageInput = struct {
    /// Filters Savings Plans coverage data by dimensions. You can filter data for
    /// Savings Plans
    /// usage with the following dimensions:
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `REGION`
    ///
    /// * `SERVICE`
    ///
    /// * `INSTANCE_FAMILY`
    ///
    /// `GetSavingsPlansCoverage` uses the same
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// as the other operations, but only `AND` is supported among each dimension.
    /// If there
    /// are multiple values for a dimension, they are OR'd together.
    ///
    /// Cost category is also supported.
    filter: ?Expression = null,

    /// The granularity of the Amazon Web Services cost data for your Savings Plans.
    /// `Granularity` can't be set if `GroupBy` is set.
    ///
    /// The `GetSavingsPlansCoverage` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: ?Granularity = null,

    /// You can group the data using the attributes `INSTANCE_FAMILY`,
    /// `REGION`, or `SERVICE`.
    group_by: ?[]const GroupDefinition = null,

    /// The number of items to be returned in a response. The default is `20`, with
    /// a
    /// minimum value of `1`.
    max_results: ?i32 = null,

    /// The measurement that you want your Savings Plans coverage reported in. The
    /// only valid
    /// value is `SpendCoveredBySavingsPlans`.
    metrics: ?[]const []const u8 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The following values are supported for `Key`:
    ///
    /// * `SpendCoveredBySavingsPlan`
    ///
    /// * `OnDemandCost`
    ///
    /// * `CoveragePercentage`
    ///
    /// * `TotalCost`
    ///
    /// * `InstanceFamily`
    ///
    /// * `Region`
    ///
    /// * `Service`
    ///
    /// The supported values for `SortOrder` are `ASCENDING` and
    /// `DESCENDING`.
    sort_by: ?SortDefinition = null,

    /// The time period that you want the usage and costs for. The `Start` date must
    /// be
    /// within 13 months. The `End` date must be after the `Start` date, and
    /// before the current date. Future dates can't be used as an `End` date.
    time_period: DateInterval,

    pub const json_field_names = .{
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .metrics = "Metrics",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetSavingsPlansCoverageOutput = struct {
    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The amount of spend that your Savings Plans covered.
    savings_plans_coverages: ?[]const SavingsPlansCoverage = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .savings_plans_coverages = "SavingsPlansCoverages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSavingsPlansCoverageInput, options: CallOptions) !GetSavingsPlansCoverageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSavingsPlansCoverageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetSavingsPlansCoverage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSavingsPlansCoverageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSavingsPlansCoverageOutput, body, allocator);
}
