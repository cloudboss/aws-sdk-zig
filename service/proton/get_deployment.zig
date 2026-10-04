const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Deployment = @import("deployment.zig").Deployment;

pub const GetDeploymentInput = struct {
    /// The name of a component that you want to get the detailed data for.
    component_name: ?[]const u8 = null,

    /// The name of a environment that you want to get the detailed data for.
    environment_name: ?[]const u8 = null,

    /// The ID of the deployment that you want to get the detailed data for.
    id: []const u8,

    /// The name of the service instance associated with the given deployment ID.
    /// `serviceName` must be specified to identify the service
    /// instance.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service associated with the given deployment ID.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_name = "componentName",
        .environment_name = "environmentName",
        .id = "id",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};

pub const GetDeploymentOutput = struct {
    /// The detailed data of the requested deployment.
    deployment: ?Deployment = null,

    pub const json_field_names = .{
        .deployment = "deployment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeploymentInput, options: CallOptions) !GetDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeploymentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.GetDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDeploymentOutput, body, allocator);
}
