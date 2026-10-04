const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineDeclaration = @import("pipeline_declaration.zig").PipelineDeclaration;

pub const UpdatePipelineInput = struct {
    /// The name of the pipeline to be updated.
    pipeline: PipelineDeclaration,

    pub const json_field_names = .{
        .pipeline = "pipeline",
    };
};

pub const UpdatePipelineOutput = struct {
    /// The structure of the updated pipeline.
    pipeline: ?PipelineDeclaration = null,

    pub const json_field_names = .{
        .pipeline = "pipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePipelineInput, options: CallOptions) !UpdatePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePipelineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.UpdatePipeline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePipelineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePipelineOutput, body, allocator);
}
