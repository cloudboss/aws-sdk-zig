const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceType = @import("source_type.zig").SourceType;
const Event = @import("event.zig").Event;

pub const DescribeEventsInput = struct {
    /// The number of minutes' worth of events to retrieve.
    duration: ?i32 = null,

    /// The end of the time interval for which to retrieve events, specified in ISO
    /// 8601
    /// format.
    end_time: ?i64 = null,

    /// The maximum number of results to include in the response. If more results
    /// exist
    /// than the specified `MaxResults` value, a token is included in the response
    /// so
    /// that the remaining results can be retrieved.
    ///
    /// The value for `MaxResults` must be between 20 and 100.
    max_results: ?i32 = null,

    /// An optional token returned from a prior request. Use this token for
    /// pagination of
    /// results from this action. If this parameter is specified, the response
    /// includes only
    /// results beyond the token, up to the value specified by
    /// `MaxResults`.
    next_token: ?[]const u8 = null,

    /// The identifier of the event source for which events will be returned. If not
    /// specified, then all sources are included in the response.
    source_name: ?[]const u8 = null,

    /// The event source to retrieve events for. If no value is specified, all
    /// events are
    /// returned.
    source_type: ?SourceType = null,

    /// The beginning of the time interval to retrieve events for, specified in ISO
    /// 8601
    /// format.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .source_name = "SourceName",
        .source_type = "SourceType",
        .start_time = "StartTime",
    };
};

pub const DescribeEventsOutput = struct {
    /// An array of events. Each element in the array represents one event.
    events: ?[]const Event = null,

    /// Provides an identifier to allow retrieval of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: CallOptions) !DescribeEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.DescribeEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventsOutput, body, allocator);
}
