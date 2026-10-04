const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeWindow = @import("time_window.zig").TimeWindow;
const SampledHTTPRequest = @import("sampled_http_request.zig").SampledHTTPRequest;

pub const GetSampledRequestsInput = struct {
    /// The number of requests that you want AWS WAF to return from among the first
    /// 5,000 requests that your AWS resource received
    /// during the time range. If your resource received fewer requests than the
    /// value of `MaxItems`, `GetSampledRequests`
    /// returns information about all of them.
    max_items: i64,

    /// `RuleId` is one of three values:
    ///
    /// * The `RuleId` of the `Rule` or the `RuleGroupId` of the `RuleGroup` for
    ///   which you want `GetSampledRequests` to return a sample of requests.
    ///
    /// * `Default_Action`, which causes `GetSampledRequests` to return a sample of
    ///   the requests that
    /// didn't match any of the rules in the specified `WebACL`.
    rule_id: []const u8,

    /// The start date and time and the end date and time of the range for which you
    /// want `GetSampledRequests` to return a
    /// sample of requests. You must specify the times in Coordinated Universal Time
    /// (UTC) format. UTC format includes the special
    /// designator, `Z`. For example, `"2016-09-27T14:50Z"`. You can specify any
    /// time range in the previous three hours.
    time_window: TimeWindow,

    /// The `WebACLId` of the `WebACL` for which you want `GetSampledRequests` to
    /// return a sample of requests.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .max_items = "MaxItems",
        .rule_id = "RuleId",
        .time_window = "TimeWindow",
        .web_acl_id = "WebAclId",
    };
};

pub const GetSampledRequestsOutput = struct {
    /// The total number of requests from which `GetSampledRequests` got a sample of
    /// `MaxItems` requests.
    /// If `PopulationSize` is less than `MaxItems`, the sample includes every
    /// request that your AWS resource
    /// received during the specified time range.
    population_size: ?i64 = null,

    /// A complex type that contains detailed information about each of the requests
    /// in the sample.
    sampled_requests: ?[]const SampledHTTPRequest = null,

    /// Usually, `TimeWindow` is the time range that you specified in the
    /// `GetSampledRequests` request. However,
    /// if your AWS resource received more than 5,000 requests during the time range
    /// that you specified in the request,
    /// `GetSampledRequests` returns the time range for the first 5,000 requests.
    /// Times are in Coordinated Universal Time (UTC) format.
    time_window: ?TimeWindow = null,

    pub const json_field_names = .{
        .population_size = "PopulationSize",
        .sampled_requests = "SampledRequests",
        .time_window = "TimeWindow",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSampledRequestsInput, options: CallOptions) !GetSampledRequestsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSampledRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.GetSampledRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSampledRequestsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSampledRequestsOutput, body, allocator);
}
