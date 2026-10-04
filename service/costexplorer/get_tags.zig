const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;

pub const GetTagsInput = struct {
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

    filter: ?Expression = null,

    /// This field is only used when SortBy is provided in the request. The maximum
    /// number of
    /// objects that are returned for this request. If MaxResults isn't specified
    /// with SortBy, the
    /// request returns 1000 results as the default value for this parameter.
    ///
    /// For `GetTags`, MaxResults has an upper quota of 1000.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The value that you want to search for.
    search_string: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The key represents cost and usage metrics. The following values are
    /// supported:
    ///
    /// * `BlendedCost`
    ///
    /// * `UnblendedCost`
    ///
    /// * `AmortizedCost`
    ///
    /// * `NetAmortizedCost`
    ///
    /// * `NetUnblendedCost`
    ///
    /// * `UsageQuantity`
    ///
    /// * `NormalizedUsageAmount`
    ///
    /// The supported values for `SortOrder` are `ASCENDING` and
    /// `DESCENDING`.
    ///
    /// When you use `SortBy`, `NextPageToken` and `SearchString`
    /// aren't supported.
    sort_by: ?[]const SortDefinition = null,

    /// The key of the tag that you want to return values for.
    tag_key: ?[]const u8 = null,

    /// The start and end dates for retrieving the dimension values. The start date
    /// is
    /// inclusive, but the end date is exclusive. For example, if `start` is
    /// `2017-01-01` and `end` is `2017-05-01`, then the cost and
    /// usage data is retrieved from `2017-01-01` up to and including
    /// `2017-04-30` but not including `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_page_token = "NextPageToken",
        .search_string = "SearchString",
        .sort_by = "SortBy",
        .tag_key = "TagKey",
        .time_period = "TimePeriod",
    };
};

pub const GetTagsOutput = struct {
    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The number of query results that Amazon Web Services returns at a time.
    return_size: i32,

    /// The tags that match your request.
    tags: ?[]const []const u8 = null,

    /// The total number of query results.
    total_size: i32,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .return_size = "ReturnSize",
        .tags = "Tags",
        .total_size = "TotalSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTagsInput, options: CallOptions) !GetTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTagsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTagsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTagsOutput, body, allocator);
}
