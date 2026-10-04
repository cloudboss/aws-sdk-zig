const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

pub const DeleteDeploymentInput = struct {
    /// The ID of the deployment.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
    };
};

pub const DeleteDeploymentOutput = struct {
    /// The status of the deployment.
    status: ?DeploymentStatus = null,

    /// The reason for the deployment status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDeploymentInput, options: CallOptions) !DeleteDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "launchwizard", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("launchwizard", "Launch Wizard", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/deleteDeployment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentId\":");
    try aws.json.writeValue(@TypeOf(input.deployment_id), input.deployment_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDeploymentOutput {
    var result: DeleteDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
