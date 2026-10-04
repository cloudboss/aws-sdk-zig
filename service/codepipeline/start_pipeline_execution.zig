const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceRevisionOverride = @import("source_revision_override.zig").SourceRevisionOverride;
const PipelineVariable = @import("pipeline_variable.zig").PipelineVariable;

pub const StartPipelineExecutionInput = struct {
    /// The system-generated unique ID used to identify a unique execution
    /// request.
    client_request_token: ?[]const u8 = null,

    /// The name of the pipeline to start.
    name: []const u8,

    /// A list that allows you to specify, or override, the source revision for a
    /// pipeline
    /// execution that's being started. A source revision is the version with all
    /// the changes to
    /// your application code, or source artifact, for the pipeline execution.
    source_revisions: ?[]const SourceRevisionOverride = null,

    /// A list that overrides pipeline variables for a pipeline execution that's
    /// being
    /// started. Variable names must match `[A-Za-z0-9@\-_]+`, and the values can be
    /// anything except an empty string.
    variables: ?[]const PipelineVariable = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .name = "name",
        .source_revisions = "sourceRevisions",
        .variables = "variables",
    };
};

pub const StartPipelineExecutionOutput = struct {
    /// The unique system-generated ID of the pipeline execution that was
    /// started.
    pipeline_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPipelineExecutionInput, options: CallOptions) !StartPipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPipelineExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.StartPipelineExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPipelineExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartPipelineExecutionOutput, body, allocator);
}
