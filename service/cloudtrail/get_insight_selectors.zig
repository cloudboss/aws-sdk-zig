const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightSelector = @import("insight_selector.zig").InsightSelector;

pub const GetInsightSelectorsInput = struct {
    /// Specifies the ARN (or ID suffix of the ARN) of the event data store for
    /// which you want to get Insights
    /// selectors.
    ///
    /// You cannot use this parameter with the `TrailName` parameter.
    event_data_store: ?[]const u8 = null,

    /// Specifies the name of the trail or trail ARN. If you specify a trail name,
    /// the string
    /// must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.),
    ///   underscores
    /// (_), or dashes (-)
    ///
    /// * Start with a letter or number, and end with a letter or number
    ///
    /// * Be between 3 and 128 characters
    ///
    /// * Have no adjacent periods, underscores or dashes. Names like
    /// `my-_namespace` and `my--namespace` are not valid.
    ///
    /// * Not be in IP address format (for example, 192.168.5.4)
    ///
    /// If you specify a trail ARN, it must be in the format:
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    ///
    /// You cannot use this parameter with the `EventDataStore` parameter.
    trail_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .trail_name = "TrailName",
    };
};

pub const GetInsightSelectorsOutput = struct {
    /// The ARN of the source event data store that enabled Insights events.
    event_data_store_arn: ?[]const u8 = null,

    /// The ARN of the destination event data store that logs Insights events.
    insights_destination: ?[]const u8 = null,

    /// Contains the Insights types that are enabled on a trail or event data store.
    /// It also specifies the event categories on which a particular Insight type is
    /// enabled.
    /// `ApiCallRateInsight` and `ApiErrorRateInsight` are valid Insight
    /// types.The EventCategory field can specify `Management` or `Data` events or
    /// both. For event data store, you can log Insights for management events only.
    insight_selectors: ?[]const InsightSelector = null,

    /// The Amazon Resource Name (ARN) of a trail for which you want to get Insights
    /// selectors.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store_arn = "EventDataStoreArn",
        .insights_destination = "InsightsDestination",
        .insight_selectors = "InsightSelectors",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInsightSelectorsInput, options: CallOptions) !GetInsightSelectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInsightSelectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetInsightSelectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInsightSelectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInsightSelectorsOutput, body, allocator);
}
