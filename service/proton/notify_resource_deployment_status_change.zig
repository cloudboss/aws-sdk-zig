const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Output = @import("output.zig").Output;
const ResourceDeploymentStatus = @import("resource_deployment_status.zig").ResourceDeploymentStatus;

pub const NotifyResourceDeploymentStatusChangeInput = struct {
    /// The deployment ID for your provisioned resource.
    deployment_id: ?[]const u8 = null,

    /// The provisioned resource state change detail data that's returned by Proton.
    outputs: ?[]const Output = null,

    /// The provisioned resource Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// The status of your provisioned resource.
    status: ?ResourceDeploymentStatus = null,

    /// The deployment status message for your provisioned resource.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .outputs = "outputs",
        .resource_arn = "resourceArn",
        .status = "status",
        .status_message = "statusMessage",
    };
};

pub const NotifyResourceDeploymentStatusChangeOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: NotifyResourceDeploymentStatusChangeInput, options: CallOptions) !NotifyResourceDeploymentStatusChangeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: NotifyResourceDeploymentStatusChangeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.NotifyResourceDeploymentStatusChange");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !NotifyResourceDeploymentStatusChangeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
