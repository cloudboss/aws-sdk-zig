const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineExecutionFilter = @import("pipeline_execution_filter.zig").PipelineExecutionFilter;
const PipelineExecutionSummary = @import("pipeline_execution_summary.zig").PipelineExecutionSummary;

pub const ListPipelineExecutionsInput = struct {
    /// The pipeline execution to filter on.
    filter: ?PipelineExecutionFilter = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned nextToken value. Pipeline
    /// history is
    /// limited to the most recent 12 months, based on pipeline execution start
    /// times. Default
    /// value is 100.
    max_results: ?i32 = null,

    /// The token that was returned from the previous `ListPipelineExecutions`
    /// call, which can be used to return the next set of pipeline executions in the
    /// list.
    next_token: ?[]const u8 = null,

    /// The name of the pipeline for which you want to get execution summary
    /// information.
    pipeline_name: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_name = "pipelineName",
    };
};

pub const ListPipelineExecutionsOutput = struct {
    /// A token that can be used in the next `ListPipelineExecutions` call. To
    /// view all items in the list, continue to call this operation with each
    /// subsequent token
    /// until no more nextToken values are returned.
    next_token: ?[]const u8 = null,

    /// A list of executions in the history of a pipeline.
    pipeline_execution_summaries: ?[]const PipelineExecutionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pipeline_execution_summaries = "pipelineExecutionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, options: CallOptions) !ListPipelineExecutionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListPipelineExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelineExecutionsOutput, body, allocator);
}
