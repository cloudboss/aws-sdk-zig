const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOperation = @import("patch_operation.zig").PatchOperation;
const MethodSnapshot = @import("method_snapshot.zig").MethodSnapshot;

pub const UpdateDeploymentInput = struct {
    /// The replacement identifier for the Deployment resource to change information
    /// about.
    deployment_id: []const u8,

    /// For more information about supported patch operations, see [Patch
    /// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
    patch_operations: ?[]const PatchOperation = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .patch_operations = "patchOperations",
        .rest_api_id = "restApiId",
    };
};

pub const UpdateDeploymentOutput = @import("deployment.zig").Deployment;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDeploymentInput, options: CallOptions) !UpdateDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.patch_operations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"patchOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDeploymentOutput {
    var result: UpdateDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
