const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const HistoryEvent = @import("history_event.zig").HistoryEvent;

pub const GetWorkflowExecutionHistoryInput = struct {
    /// The name of the domain containing the workflow execution.
    domain: []const u8,

    /// Specifies the workflow execution for which to return the history.
    execution: WorkflowExecution,

    /// The maximum number of results that are returned per call.
    /// Use `nextPageToken` to obtain further pages of results.
    maximum_page_size: ?i32 = null,

    /// If `NextPageToken` is returned there are more results
    /// available. The value of `NextPageToken` is a unique pagination token for
    /// each page. Make the call again using
    /// the returned token to retrieve the next page. Keep all other arguments
    /// unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token will return a `400` error:
    /// "`Specified token has
    /// exceeded its maximum lifetime`".
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    /// When set to `true`, returns the events in reverse order. By default the
    /// results are returned in ascending order of the `eventTimeStamp` of the
    /// events.
    reverse_order: ?bool = null,

    pub const json_field_names = .{
        .domain = "domain",
        .execution = "execution",
        .maximum_page_size = "maximumPageSize",
        .next_page_token = "nextPageToken",
        .reverse_order = "reverseOrder",
    };
};

pub const GetWorkflowExecutionHistoryOutput = struct {
    /// The list of history events.
    events: ?[]const HistoryEvent = null,

    /// If a `NextPageToken` was returned by a previous call, there are more
    /// results available. To retrieve the next page of results, make the call again
    /// using the returned token in
    /// `nextPageToken`. Keep all other arguments unchanged.
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .next_page_token = "nextPageToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowExecutionHistoryInput, options: CallOptions) !GetWorkflowExecutionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowExecutionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.GetWorkflowExecutionHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowExecutionHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetWorkflowExecutionHistoryOutput, body, allocator);
}
