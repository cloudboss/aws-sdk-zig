const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const TimeWindow = @import("time_window.zig").TimeWindow;
const PathStatistics = @import("path_statistics.zig").PathStatistics;

pub const GetTopPathStatisticsByTrafficInput = struct {
    /// Filters the results to include only traffic from bots in the specified
    /// category. For example, you can filter by `ai`
    /// to see only AI crawler traffic, or `search_engine` to see only search engine
    /// bot traffic.
    /// When you apply this filter, the `Source` field is populated in the response.
    bot_category: ?[]const u8 = null,

    /// Filters the results to include only traffic from the specified bot. For
    /// example, you can filter by `gptbot` or `googlebot`.
    /// When you apply this filter, the `Source` field is populated in the response.
    bot_name: ?[]const u8 = null,

    /// Filters the results to include only traffic from bots belonging to the
    /// specified organization. For example, you can filter by `openai` or `google`.
    /// When you apply this filter, the `Source` field is populated in the response.
    bot_organization: ?[]const u8 = null,

    /// The maximum number of path statistics to return. Valid values are 1 to 100.
    limit: i32,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available for retrieval exceeds the limit, WAF
    /// returns a `NextMarker` value in the response. To retrieve the next batch of
    /// objects,
    /// provide the marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// The maximum number of top bots to include in the statistics for each path.
    /// Valid values are 1 to 10.
    number_of_top_traffic_bots_per_path: i32,

    /// Specifies whether the web ACL is for an Amazon Web Services CloudFront
    /// distribution or for a regional application.
    /// A regional application can be an Application Load Balancer, an AppSync
    /// GraphQL API, an Amazon Cognito user pool,
    /// an Amazon Web Services App Runner service, or an Amazon Web Services
    /// Verified Access instance.
    scope: Scope,

    /// The time window for which you want to retrieve path statistics. The time
    /// window must be within the data retention period for your web ACL.
    time_window: TimeWindow,

    /// A URI path prefix to filter the results. When you specify this parameter,
    /// the operation returns statistics for individual URIs within the specified
    /// path prefix.
    /// For example, if you specify `/api`, the response includes statistics for
    /// paths like `/api/v1/users` and `/api/v2/orders`.
    /// If you don't specify this parameter, the operation returns top-level path
    /// statistics.
    uri_path_prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the web ACL for which you want to retrieve
    /// path statistics.
    web_acl_arn: []const u8,

    pub const json_field_names = .{
        .bot_category = "BotCategory",
        .bot_name = "BotName",
        .bot_organization = "BotOrganization",
        .limit = "Limit",
        .next_marker = "NextMarker",
        .number_of_top_traffic_bots_per_path = "NumberOfTopTrafficBotsPerPath",
        .scope = "Scope",
        .time_window = "TimeWindow",
        .uri_path_prefix = "UriPathPrefix",
        .web_acl_arn = "WebAclArn",
    };
};

pub const GetTopPathStatisticsByTrafficOutput = struct {
    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that
    /// are still available for retrieval exceeds the limit, WAF returns a
    /// `NextMarker` value in the response.
    /// To retrieve the next batch of objects, provide the marker from the prior
    /// call in your next request.
    next_marker: ?[]const u8 = null,

    /// The list of path statistics, ordered by request count. Each entry includes
    /// the path, request count,
    /// percentage of total traffic, and the top bots accessing that path.
    path_statistics: ?[]const PathStatistics = null,

    /// Category-level aggregations for visualizing bot category to path
    /// relationships. This field is only populated when no bot filters are applied
    /// to the request.
    /// Each entry includes the bot category and the paths accessed by bots in that
    /// category.
    top_categories: ?[]const PathStatistics = null,

    /// The total number of requests that match the query criteria within the
    /// specified time window.
    total_request_count: ?i64 = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .path_statistics = "PathStatistics",
        .top_categories = "TopCategories",
        .total_request_count = "TotalRequestCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTopPathStatisticsByTrafficInput, options: CallOptions) !GetTopPathStatisticsByTrafficOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTopPathStatisticsByTrafficInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetTopPathStatisticsByTraffic");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTopPathStatisticsByTrafficOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTopPathStatisticsByTrafficOutput, body, allocator);
}
