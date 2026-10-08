const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterValue = @import("parameter_value.zig").ParameterValue;

pub const ActivatePipelineInput = struct {
    /// A list of parameter values to pass to the pipeline at activation.
    parameter_values: ?[]const ParameterValue = null,

    /// The ID of the pipeline.
    pipeline_id: []const u8,

    /// The date and time to resume the pipeline. By default, the pipeline resumes
    /// from the last completed execution.
    start_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .parameter_values = "parameterValues",
        .pipeline_id = "pipelineId",
        .start_timestamp = "startTimestamp",
    };
};

pub const ActivatePipelineOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ActivatePipelineInput, options: CallOptions) !ActivatePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ActivatePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ActivatePipeline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ActivatePipelineOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
