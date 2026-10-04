const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceType = @import("source_type.zig").SourceType;
const Event = @import("event.zig").Event;

pub const DescribeEventsInput = struct {
    /// The number of minutes worth of events to retrieve.
    duration: ?i32 = null,

    /// The end of the time interval for which to retrieve events, specified in ISO
    /// 8601 format.
    ///
    /// Example: 2017-03-30T07:03:49.555Z
    end_time: ?i64 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// The identifier of the event source for which events are returned. If not
    /// specified, all sources are included in the response.
    source_name: ?[]const u8 = null,

    /// The event source to retrieve events for. If no value is specified, all
    /// events are returned.
    source_type: ?SourceType = null,

    /// The beginning of the time interval to retrieve events for, specified in ISO
    /// 8601 format.
    ///
    /// Example: 2017-03-30T07:03:49.555Z
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
    /// A list of events. Each element in the list contains detailed information
    /// about one event.
    events: ?[]const Event = null,

    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventsOutput, body, allocator);
}
