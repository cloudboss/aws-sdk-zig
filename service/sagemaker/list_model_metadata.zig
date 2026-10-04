const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelMetadataSearchExpression = @import("model_metadata_search_expression.zig").ModelMetadataSearchExpression;
const ModelMetadataSummary = @import("model_metadata_summary.zig").ModelMetadataSummary;

pub const ListModelMetadataInput = struct {
    /// The maximum number of models to return in the response.
    max_results: ?i32 = null,

    /// If the response to a previous `ListModelMetadataResponse` request was
    /// truncated, the response includes a NextToken. To retrieve the next set of
    /// model metadata, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// One or more filters that searches for the specified resource or resources in
    /// a search. All resource objects that satisfy the expression's condition are
    /// included in the search results. Specify the Framework, FrameworkVersion,
    /// Domain or Task to filter supported. Filter names and values are
    /// case-sensitive.
    search_expression: ?ModelMetadataSearchExpression = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .search_expression = "SearchExpression",
    };
};

pub const ListModelMetadataOutput = struct {
    /// A structure that holds model metadata.
    model_metadata_summaries: ?[]const ModelMetadataSummary = null,

    /// A token for getting the next set of recommendations, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_metadata_summaries = "ModelMetadataSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelMetadataInput, options: CallOptions) !ListModelMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelMetadataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelMetadataOutput, body, allocator);
}
