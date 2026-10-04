const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightSelector = @import("insight_selector.zig").InsightSelector;

pub const PutInsightSelectorsInput = struct {
    /// The ARN (or ID suffix of the ARN) of the source event data store for which
    /// you want to change or add Insights
    /// selectors. To enable Insights on an event data store, you must provide both
    /// the
    /// `EventDataStore` and `InsightsDestination` parameters.
    ///
    /// You cannot use this parameter with the `TrailName` parameter.
    event_data_store: ?[]const u8 = null,

    /// The ARN (or ID suffix of the ARN) of the destination event data store that
    /// logs Insights events. To enable Insights on an event data store, you must
    /// provide both the
    /// `EventDataStore` and `InsightsDestination` parameters.
    ///
    /// You cannot use this parameter with the `TrailName` parameter.
    insights_destination: ?[]const u8 = null,

    /// Contains the Insights types you want to log on a specific category of events
    /// on a trail or event data store.
    /// `ApiCallRateInsight` and `ApiErrorRateInsight` are valid Insight
    /// types.The EventCategory field can specify `Management` or `Data` events or
    /// both. For event data store, you can log Insights for management events only.
    ///
    /// The `ApiCallRateInsight` Insights type analyzes write-only management
    /// API calls or read and write data API calls that are aggregated per minute
    /// against a baseline API call volume.
    ///
    /// The `ApiErrorRateInsight` Insights type analyzes management and data
    /// API calls that result in error codes. The error is shown if the API call is
    /// unsuccessful.
    insight_selectors: []const InsightSelector,

    /// The name of the CloudTrail trail for which you want to change or add
    /// Insights
    /// selectors.
    ///
    /// You cannot use this parameter with the `EventDataStore` and
    /// `InsightsDestination` parameters.
    trail_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .insights_destination = "InsightsDestination",
        .insight_selectors = "InsightSelectors",
        .trail_name = "TrailName",
    };
};

pub const PutInsightSelectorsOutput = struct {
    /// The Amazon Resource Name (ARN) of the source event data store for which you
    /// want to change or add Insights
    /// selectors.
    event_data_store_arn: ?[]const u8 = null,

    /// The ARN of the destination event data store that logs Insights events.
    insights_destination: ?[]const u8 = null,

    /// Contains the Insights types you want to log on a specific category of events
    /// in a trail or event data store.
    /// `ApiCallRateInsight` and `ApiErrorRateInsight` are valid Insight
    /// types.The EventCategory field can specify `Management` or `Data` events or
    /// both. For event data store, you can only log Insights for management events
    /// only.
    insight_selectors: ?[]const InsightSelector = null,

    /// The Amazon Resource Name (ARN) of a trail for which you want to change or
    /// add Insights
    /// selectors.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store_arn = "EventDataStoreArn",
        .insights_destination = "InsightsDestination",
        .insight_selectors = "InsightSelectors",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutInsightSelectorsInput, options: CallOptions) !PutInsightSelectorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutInsightSelectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.PutInsightSelectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutInsightSelectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutInsightSelectorsOutput, body, allocator);
}
