const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServicePipeline = @import("service_pipeline.zig").ServicePipeline;

pub const CancelServicePipelineDeploymentInput = struct {
    /// The name of the service with the service pipeline deployment to cancel.
    service_name: []const u8,

    pub const json_field_names = .{
        .service_name = "serviceName",
    };
};

pub const CancelServicePipelineDeploymentOutput = struct {
    /// The service pipeline detail data that's returned by Proton.
    pipeline: ?ServicePipeline = null,

    pub const json_field_names = .{
        .pipeline = "pipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelServicePipelineDeploymentInput, options: CallOptions) !CancelServicePipelineDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelServicePipelineDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CancelServicePipelineDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelServicePipelineDeploymentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CancelServicePipelineDeploymentOutput, body, allocator);
}
