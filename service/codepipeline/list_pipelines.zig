const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineSummary = @import("pipeline_summary.zig").PipelineSummary;

pub const ListPipelinesInput = struct {
    /// The maximum number of pipelines to return in a single call. To retrieve the
    /// remaining
    /// pipelines, make another call with the returned nextToken value. The minimum
    /// value you
    /// can specify is 1. The maximum accepted value is 1000.
    max_results: ?i32 = null,

    /// An identifier that was returned from the previous list pipelines call. It
    /// can be
    /// used to return the next set of pipelines in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListPipelinesOutput = struct {
    /// If the amount of returned information is significantly large, an identifier
    /// is also
    /// returned. It can be used in a subsequent list pipelines call to return the
    /// next set of
    /// pipelines in the list.
    next_token: ?[]const u8 = null,

    /// The list of pipelines.
    pipelines: ?[]const PipelineSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pipelines = "pipelines",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelinesInput, options: CallOptions) !ListPipelinesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelinesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListPipelines");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelinesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelinesOutput, body, allocator);
}
