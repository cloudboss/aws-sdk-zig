const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortArtifactsBy = @import("sort_artifacts_by.zig").SortArtifactsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ArtifactSummary = @import("artifact_summary.zig").ArtifactSummary;

pub const ListArtifactsInput = struct {
    /// A filter that returns only artifacts of the specified type.
    artifact_type: ?[]const u8 = null,

    /// A filter that returns only artifacts created on or after the specified time.
    created_after: ?i64 = null,

    /// A filter that returns only artifacts created on or before the specified
    /// time.
    created_before: ?i64 = null,

    /// The maximum number of artifacts to return in the response. The default value
    /// is 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListArtifacts` didn't return the full set of
    /// artifacts, the call returns a token for getting the next set of artifacts.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?SortArtifactsBy = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only artifacts with the specified source URI.
    source_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_type = "ArtifactType",
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .source_uri = "SourceUri",
    };
};

pub const ListArtifactsOutput = struct {
    /// A list of artifacts and their properties.
    artifact_summaries: ?[]const ArtifactSummary = null,

    /// A token for getting the next set of artifacts, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_summaries = "ArtifactSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListArtifactsInput, options: CallOptions) !ListArtifactsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListArtifactsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListArtifacts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListArtifactsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListArtifactsOutput, body, allocator);
}
