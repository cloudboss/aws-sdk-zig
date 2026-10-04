const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Step = @import("step.zig").Step;

pub const DescribeStepInput = struct {
    /// The identifier of the cluster with steps to describe.
    cluster_id: []const u8,

    /// The identifier of the step to describe.
    step_id: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .step_id = "StepId",
    };
};

pub const DescribeStepOutput = struct {
    /// The step details for the requested step identifier.
    step: ?Step = null,

    pub const json_field_names = .{
        .step = "Step",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStepInput, options: CallOptions) !DescribeStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.DescribeStep");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStepOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeStepOutput, body, allocator);
}
