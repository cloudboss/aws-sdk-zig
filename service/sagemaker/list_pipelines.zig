const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortPipelinesBy = @import("sort_pipelines_by.zig").SortPipelinesBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const PipelineSummary = @import("pipeline_summary.zig").PipelineSummary;

pub const ListPipelinesInput = struct {
    /// A filter that returns the pipelines that were created after a specified
    /// time.
    created_after: ?i64 = null,

    /// A filter that returns the pipelines that were created before a specified
    /// time.
    created_before: ?i64 = null,

    /// The maximum number of pipelines to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous `ListPipelines` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of pipelines, use
    /// the token in the next request.
    next_token: ?[]const u8 = null,

    /// The prefix of the pipeline name.
    pipeline_name_prefix: ?[]const u8 = null,

    /// The field by which to sort results. The default is `CreatedTime`.
    sort_by: ?SortPipelinesBy = null,

    /// The sort order for results.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pipeline_name_prefix = "PipelineNamePrefix",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListPipelinesOutput = struct {
    /// If the result of the previous `ListPipelines` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of pipelines, use
    /// the token in the next request.
    next_token: ?[]const u8 = null,

    /// Contains a sorted list of `PipelineSummary` objects matching the specified
    /// filters. Each `PipelineSummary` consists of PipelineArn, PipelineName,
    /// ExperimentName, PipelineDescription, CreationTime, LastModifiedTime,
    /// LastRunTime, and RoleArn. This list can be empty.
    pipeline_summaries: ?[]const PipelineSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .pipeline_summaries = "PipelineSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelinesInput, options: CallOptions) !ListPipelinesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListPipelines");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelinesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelinesOutput, body, allocator);
}
