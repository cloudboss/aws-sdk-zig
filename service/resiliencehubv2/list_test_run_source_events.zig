const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestRunSourceEvent = @import("test_run_source_event.zig").TestRunSourceEvent;

pub const ListTestRunSourceEventsInput = struct {
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The ARN of the service the test run belongs to.
    service_arn: []const u8,

    /// The ARN of the monitoring source to list events for, such as the ARN of a
    /// CloudWatch alarm. If the source was not monitored during the test run, the
    /// response is an empty list.
    source_arn: []const u8,

    /// The identifier of the test run to list source events for.
    test_run_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_arn = "serviceArn",
        .source_arn = "sourceArn",
        .test_run_id = "testRunId",
    };
};

pub const ListTestRunSourceEventsOutput = struct {
    next_token: ?[]const u8 = null,

    /// The list of source events, in chronological order.
    test_run_source_events: ?[]const TestRunSourceEvent = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .test_run_source_events = "testRunSourceEvents",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTestRunSourceEventsInput, options: CallOptions) !ListTestRunSourceEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTestRunSourceEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/test-runs/");
    try path_buf.appendSlice(allocator, input.test_run_id);
    try path_buf.appendSlice(allocator, "/source-events");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "serviceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.service_arn);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sourceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.source_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTestRunSourceEventsOutput {
    const result: ListTestRunSourceEventsOutput = try aws.json.parseJsonObject(
        ListTestRunSourceEventsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
