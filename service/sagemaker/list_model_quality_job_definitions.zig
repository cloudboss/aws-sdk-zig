const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitoringJobDefinitionSortKey = @import("monitoring_job_definition_sort_key.zig").MonitoringJobDefinitionSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const MonitoringJobDefinitionSummary = @import("monitoring_job_definition_summary.zig").MonitoringJobDefinitionSummary;

pub const ListModelQualityJobDefinitionsInput = struct {
    /// A filter that returns only model quality monitoring job definitions created
    /// after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only model quality monitoring job definitions created
    /// before the specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only model quality monitoring job definitions that are
    /// associated with the specified endpoint.
    endpoint_name: ?[]const u8 = null,

    /// The maximum number of results to return in a call to
    /// `ListModelQualityJobDefinitions`.
    max_results: ?i32 = null,

    /// A string in the transform job name. This filter returns only model quality
    /// monitoring job definitions whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListModelQualityJobDefinitions` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// model quality monitoring job definitions, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?MonitoringJobDefinitionSortKey = null,

    /// Whether to sort the results in `Ascending` or `Descending` order. The
    /// default is `Descending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .endpoint_name = "EndpointName",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelQualityJobDefinitionsOutput = struct {
    /// A list of summaries of model quality monitoring job definitions.
    job_definition_summaries: ?[]const MonitoringJobDefinitionSummary = null,

    /// If the response is truncated, Amazon SageMaker AI returns this token. To
    /// retrieve the next set of model quality monitoring job definitions, use it in
    /// the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_definition_summaries = "JobDefinitionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelQualityJobDefinitionsInput, options: CallOptions) !ListModelQualityJobDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelQualityJobDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelQualityJobDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelQualityJobDefinitionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelQualityJobDefinitionsOutput, body, allocator);
}
