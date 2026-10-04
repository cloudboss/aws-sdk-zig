const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SavingsPlansDataType = @import("savings_plans_data_type.zig").SavingsPlansDataType;
const Expression = @import("expression.zig").Expression;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const SavingsPlansUtilizationDetail = @import("savings_plans_utilization_detail.zig").SavingsPlansUtilizationDetail;
const SavingsPlansUtilizationAggregates = @import("savings_plans_utilization_aggregates.zig").SavingsPlansUtilizationAggregates;

pub const GetSavingsPlansUtilizationDetailsInput = struct {
    /// The data type.
    data_type: ?[]const SavingsPlansDataType = null,

    /// Filters Savings Plans utilization coverage data for active Savings Plans
    /// dimensions. You
    /// can filter data with the following dimensions:
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `SAVINGS_PLAN_ARN`
    ///
    /// * `REGION`
    ///
    /// * `PAYMENT_OPTION`
    ///
    /// * `INSTANCE_TYPE_FAMILY`
    ///
    /// `GetSavingsPlansUtilizationDetails` uses the same
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// as the other operations, but only `AND` is supported among each dimension.
    filter: ?Expression = null,

    /// The number of items to be returned in a response. The default is `20`, with
    /// a
    /// minimum value of `1`.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The following values are supported for `Key`:
    ///
    /// * `UtilizationPercentage`
    ///
    /// * `TotalCommitment`
    ///
    /// * `UsedCommitment`
    ///
    /// * `UnusedCommitment`
    ///
    /// * `NetSavings`
    ///
    /// * `AmortizedRecurringCommitment`
    ///
    /// * `AmortizedUpfrontCommitment`
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
        .data_type = "DataType",
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetSavingsPlansUtilizationDetailsOutput = struct {
    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// Retrieves a single daily or monthly Savings Plans utilization rate and
    /// details for your
    /// account.
    savings_plans_utilization_details: ?[]const SavingsPlansUtilizationDetail = null,

    time_period: ?DateInterval = null,

    /// The total Savings Plans utilization, regardless of time period.
    total: ?SavingsPlansUtilizationAggregates = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .savings_plans_utilization_details = "SavingsPlansUtilizationDetails",
        .time_period = "TimePeriod",
        .total = "Total",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSavingsPlansUtilizationDetailsInput, options: CallOptions) !GetSavingsPlansUtilizationDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSavingsPlansUtilizationDetailsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetSavingsPlansUtilizationDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSavingsPlansUtilizationDetailsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSavingsPlansUtilizationDetailsOutput, body, allocator);
}
