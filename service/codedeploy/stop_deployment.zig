const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StopStatus = @import("stop_status.zig").StopStatus;

pub const StopDeploymentInput = struct {
    /// Indicates, when a deployment is stopped, whether instances that have been
    /// updated
    /// should be rolled back to the previous version of the application revision.
    auto_rollback_enabled: ?bool = null,

    /// The unique ID of a deployment.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .auto_rollback_enabled = "autoRollbackEnabled",
        .deployment_id = "deploymentId",
    };
};

pub const StopDeploymentOutput = struct {
    /// The status of the stop deployment operation:
    ///
    /// * Pending: The stop operation is pending.
    ///
    /// * Succeeded: The stop operation was successful.
    status: ?StopStatus = null,

    /// An accompanying status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .status_message = "statusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopDeploymentInput, options: CallOptions) !StopDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.StopDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopDeploymentOutput, body, allocator);
}
