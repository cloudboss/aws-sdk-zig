const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonStatus = @import("daemon_status.zig").DaemonStatus;

pub const DeleteDaemonInput = struct {
    /// The Amazon Resource Name (ARN) of the daemon to delete.
    daemon_arn: []const u8,

    pub const json_field_names = .{
        .daemon_arn = "daemonArn",
    };
};

pub const DeleteDaemonOutput = struct {
    /// The Unix timestamp for the time when the daemon was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the daemon deployment that was triggered
    /// by the delete operation. This deployment drains existing daemon tasks from
    /// the container instances.
    deployment_arn: ?[]const u8 = null,

    /// The status of the daemon. After you call `DeleteDaemon`, the status changes
    /// to `DELETE_IN_PROGRESS`.
    status: ?DaemonStatus = null,

    /// The Unix timestamp for the time when the daemon was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .deployment_arn = "deploymentArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDaemonInput, options: CallOptions) !DeleteDaemonOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDaemonInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DeleteDaemon");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDaemonOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteDaemonOutput, body, allocator);
}
