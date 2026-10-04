const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionExecutionFilter = @import("action_execution_filter.zig").ActionExecutionFilter;
const ActionExecutionDetail = @import("action_execution_detail.zig").ActionExecutionDetail;

pub const ListActionExecutionsInput = struct {
    /// Input information used to filter action execution history.
    filter: ?ActionExecutionFilter = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned nextToken value. Action
    /// execution history
    /// is retained for up to 12 months, based on action execution start times.
    /// Default value is
    /// 100.
    max_results: ?i32 = null,

    /// The token that was returned from the previous `ListActionExecutions` call,
    /// which can be used to return the next set of action executions in the list.
    next_token: ?[]const u8 = null,

    /// The name of the pipeline for which you want to list action execution
    /// history.
    pipeline_name: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_name = "pipelineName",
    };
};

pub const ListActionExecutionsOutput = struct {
    /// The details for a list of recent executions, such as action execution ID.
    action_execution_details: ?[]const ActionExecutionDetail = null,

    /// If the amount of returned information is significantly large, an identifier
    /// is also
    /// returned and can be used in a subsequent `ListActionExecutions` call to
    /// return the next set of action executions in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_execution_details = "actionExecutionDetails",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListActionExecutionsInput, options: CallOptions) !ListActionExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListActionExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListActionExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListActionExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListActionExecutionsOutput, body, allocator);
}
