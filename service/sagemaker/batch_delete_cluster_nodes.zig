const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchDeleteClusterNodesError = @import("batch_delete_cluster_nodes_error.zig").BatchDeleteClusterNodesError;
const BatchDeleteClusterNodeLogicalIdsError = @import("batch_delete_cluster_node_logical_ids_error.zig").BatchDeleteClusterNodeLogicalIdsError;

pub const BatchDeleteClusterNodesInput = struct {
    /// The name of the SageMaker HyperPod cluster from which to delete the
    /// specified nodes.
    cluster_name: []const u8,

    /// A list of node IDs to be deleted from the specified cluster.
    ///
    /// * For SageMaker HyperPod clusters using the Slurm workload manager, you
    ///   cannot remove instances that are configured as Slurm controller nodes.
    /// * If you need to delete more than 99 instances, contact
    ///   [Support](http://aws.amazon.com/contact-us/) for assistance.
    node_ids: ?[]const []const u8 = null,

    /// A list of `NodeLogicalIds` identifying the nodes to be deleted. You can
    /// specify up to 50 `NodeLogicalIds`. You must specify either `NodeLogicalIds`,
    /// `InstanceIds`, or both, with a combined maximum of 50 identifiers.
    node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .node_ids = "NodeIds",
        .node_logical_ids = "NodeLogicalIds",
    };
};

pub const BatchDeleteClusterNodesOutput = struct {
    /// A list of errors encountered when deleting the specified nodes.
    failed: ?[]const BatchDeleteClusterNodesError = null,

    /// A list of `NodeLogicalIds` that could not be deleted, along with error
    /// information explaining why the deletion failed.
    failed_node_logical_ids: ?[]const BatchDeleteClusterNodeLogicalIdsError = null,

    /// A list of node IDs that were successfully deleted from the specified
    /// cluster.
    successful: ?[]const []const u8 = null,

    /// A list of `NodeLogicalIds` that were successfully deleted from the cluster.
    successful_node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .failed_node_logical_ids = "FailedNodeLogicalIds",
        .successful = "Successful",
        .successful_node_logical_ids = "SuccessfulNodeLogicalIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteClusterNodesInput, options: CallOptions) !BatchDeleteClusterNodesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteClusterNodesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.BatchDeleteClusterNodes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteClusterNodesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteClusterNodesOutput, body, allocator);
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
