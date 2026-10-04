const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;

pub const GetCostCategoriesInput = struct {
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

    cost_category_name: ?[]const u8 = null,

    filter: ?Expression = null,

    /// This field is only used when the `SortBy` value is provided in the
    /// request.
    ///
    /// The maximum number of objects that are returned for this request. If
    /// `MaxResults` isn't specified with the `SortBy` value, the request
    /// returns 1000 results as the default value for this parameter.
    ///
    /// For `GetCostCategories`, MaxResults has an upper quota of 1000.
    max_results: ?i32 = null,

    /// If the number of objects that are still available for retrieval exceeds the
    /// quota, Amazon Web Services returns a NextPageToken value in the response. To
    /// retrieve the next batch of
    /// objects, provide the NextPageToken from the previous call in your next
    /// request.
    next_page_token: ?[]const u8 = null,

    /// The value that you want to search the filter values for.
    ///
    /// If you don't specify a `CostCategoryName`, `SearchString` is used to
    /// filter cost category names that match the `SearchString` pattern. If you
    /// specify a
    /// `CostCategoryName`, `SearchString` is used to filter cost category
    /// values that match the `SearchString` pattern.
    search_string: ?[]const u8 = null,

    /// The value that you sort the data by.
    ///
    /// The key represents the cost and usage metrics. The following values are
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
    /// The supported key values for the `SortOrder` value are `ASCENDING`
    /// and `DESCENDING`.
    ///
    /// When you use the `SortBy` value, the `NextPageToken` and
    /// `SearchString` key values aren't supported.
    sort_by: ?[]const SortDefinition = null,

    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .cost_category_name = "CostCategoryName",
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_page_token = "NextPageToken",
        .search_string = "SearchString",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetCostCategoriesOutput = struct {
    /// The names of the cost categories.
    cost_category_names: ?[]const []const u8 = null,

    /// The cost category values.
    ///
    /// If the `CostCategoryName` key isn't specified in the request, the
    /// `CostCategoryValues` fields aren't returned.
    cost_category_values: ?[]const []const u8 = null,

    /// If the number of objects that are still available for retrieval exceeds the
    /// quota, Amazon Web Services returns a NextPageToken value in the response. To
    /// retrieve the next batch of
    /// objects, provide the marker from the prior call in your next request.
    next_page_token: ?[]const u8 = null,

    /// The number of objects that are returned.
    return_size: i32,

    /// The total number of objects.
    total_size: i32,

    pub const json_field_names = .{
        .cost_category_names = "CostCategoryNames",
        .cost_category_values = "CostCategoryValues",
        .next_page_token = "NextPageToken",
        .return_size = "ReturnSize",
        .total_size = "TotalSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostCategoriesInput, options: CallOptions) !GetCostCategoriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostCategoriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCostCategories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostCategoriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCostCategoriesOutput, body, allocator);
}
