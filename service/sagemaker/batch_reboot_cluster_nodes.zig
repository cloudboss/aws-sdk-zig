const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchRebootClusterNodesError = @import("batch_reboot_cluster_nodes_error.zig").BatchRebootClusterNodesError;
const BatchRebootClusterNodeLogicalIdsError = @import("batch_reboot_cluster_node_logical_ids_error.zig").BatchRebootClusterNodeLogicalIdsError;

pub const BatchRebootClusterNodesInput = struct {
    /// The name or Amazon Resource Name (ARN) of the SageMaker HyperPod cluster
    /// containing the nodes to reboot.
    cluster_name: []const u8,

    /// A list of EC2 instance IDs to reboot using soft recovery. You can specify
    /// between 1 and 25 instance IDs.
    ///
    /// * Either `NodeIds` or `NodeLogicalIds` must be provided (or both), but at
    ///   least one is required.
    /// * Each instance ID must follow the pattern `i-` followed by 17 hexadecimal
    ///   characters (for example, `i-0123456789abcdef0`).
    node_ids: ?[]const []const u8 = null,

    /// A list of logical node IDs to reboot using soft recovery. You can specify
    /// between 1 and 25 logical node IDs.
    ///
    /// The `NodeLogicalId` is a unique identifier that persists throughout the
    /// node's lifecycle and can be used to track nodes that are still being
    /// provisioned and don't yet have an EC2 instance ID assigned.
    ///
    /// * This parameter is only supported for clusters using `Continuous` as the
    ///   `NodeProvisioningMode`. For clusters using the default provisioning mode,
    ///   use `NodeIds` instead.
    /// * Either `NodeIds` or `NodeLogicalIds` must be provided (or both), but at
    ///   least one is required.
    node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .node_ids = "NodeIds",
        .node_logical_ids = "NodeLogicalIds",
    };
};

pub const BatchRebootClusterNodesOutput = struct {
    /// A list of errors encountered for EC2 instance IDs that could not be
    /// rebooted. Each error includes the instance ID, an error code, and a
    /// descriptive message.
    failed: ?[]const BatchRebootClusterNodesError = null,

    /// A list of errors encountered for logical node IDs that could not be
    /// rebooted. Each error includes the logical node ID, an error code, and a
    /// descriptive message. This field is only present when `NodeLogicalIds` were
    /// provided in the request.
    failed_node_logical_ids: ?[]const BatchRebootClusterNodeLogicalIdsError = null,

    /// A list of EC2 instance IDs for which the reboot operation was successfully
    /// initiated.
    successful: ?[]const []const u8 = null,

    /// A list of logical node IDs for which the reboot operation was successfully
    /// initiated. This field is only present when `NodeLogicalIds` were provided in
    /// the request.
    successful_node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .failed_node_logical_ids = "FailedNodeLogicalIds",
        .successful = "Successful",
        .successful_node_logical_ids = "SuccessfulNodeLogicalIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchRebootClusterNodesInput, options: CallOptions) !BatchRebootClusterNodesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: BatchRebootClusterNodesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.BatchRebootClusterNodes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchRebootClusterNodesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchRebootClusterNodesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
