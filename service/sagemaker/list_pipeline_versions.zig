const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const PipelineVersionSummary = @import("pipeline_version_summary.zig").PipelineVersionSummary;

pub const ListPipelineVersionsInput = struct {
    /// A filter that returns the pipeline versions that were created after a
    /// specified time.
    created_after: ?i64 = null,

    /// A filter that returns the pipeline versions that were created before a
    /// specified time.
    created_before: ?i64 = null,

    /// The maximum number of pipeline versions to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous `ListPipelineVersions` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of pipeline
    /// versions, use this token in your next request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_name: []const u8,

    /// The sort order for the results.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pipeline_name = "PipelineName",
        .sort_order = "SortOrder",
    };
};

pub const ListPipelineVersionsOutput = struct {
    /// If the result of the previous `ListPipelineVersions` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of pipeline
    /// versions, use this token in your next request.
    next_token: ?[]const u8 = null,

    /// Contains a sorted list of pipeline version summary objects matching the
    /// specified filters. Each version summary includes the pipeline version ID,
    /// the creation date, and the last pipeline execution created from that
    /// version. This list can be empty.
    pipeline_version_summaries: ?[]const PipelineVersionSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .pipeline_version_summaries = "PipelineVersionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineVersionsInput, options: CallOptions) !ListPipelineVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListPipelineVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelineVersionsOutput, body, allocator);
}
