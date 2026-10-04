const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HistoryEvent = @import("history_event.zig").HistoryEvent;

pub const GetExecutionHistoryInput = struct {
    /// The Amazon Resource Name (ARN) of the execution.
    execution_arn: []const u8,

    /// You can select whether execution data (input or output of a history event)
    /// is returned.
    /// The default is `true`.
    include_execution_data: ?bool = null,

    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to obtain further pages of results.
    /// The default is 100 and the maximum allowed page size is 1000. A value of 0
    /// uses the default.
    ///
    /// This is only an upper limit. The actual number of results returned per call
    /// might be fewer than the specified maximum.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    /// Lists events in descending order of their `timeStamp`.
    reverse_order: ?bool = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .include_execution_data = "includeExecutionData",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .reverse_order = "reverseOrder",
    };
};

pub const GetExecutionHistoryOutput = struct {
    /// The list of events that occurred in the execution.
    events: ?[]const HistoryEvent = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExecutionHistoryInput, options: CallOptions) !GetExecutionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExecutionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.GetExecutionHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExecutionHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetExecutionHistoryOutput, body, allocator);
}
