const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddClusterNodeSpecification = @import("add_cluster_node_specification.zig").AddClusterNodeSpecification;
const BatchAddClusterNodesError = @import("batch_add_cluster_nodes_error.zig").BatchAddClusterNodesError;
const NodeAdditionResult = @import("node_addition_result.zig").NodeAdditionResult;

pub const BatchAddClusterNodesInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This token is valid for 8 hours. If you retry
    /// the request with the same client token within this timeframe and the same
    /// parameters, the API returns the same set of `NodeLogicalIds` with their
    /// latest status.
    client_token: ?[]const u8 = null,

    /// The name of the HyperPod cluster to which you want to add nodes.
    cluster_name: []const u8,

    /// A list of instance groups and the number of nodes to add to each. You can
    /// specify up to 5 instance groups in a single request, with a maximum of 50
    /// nodes total across all instance groups.
    nodes_to_add: []const AddClusterNodeSpecification,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .cluster_name = "ClusterName",
        .nodes_to_add = "NodesToAdd",
    };
};

pub const BatchAddClusterNodesOutput = struct {
    /// A list of errors that occurred during the node addition operation. Each
    /// entry includes the instance group name, error code, number of failed
    /// additions, and an error message.
    failed: ?[]const BatchAddClusterNodesError = null,

    /// A list of `NodeLogicalIDs` that were successfully added to the cluster. The
    /// `NodeLogicalID` is unique per cluster and does not change between instance
    /// replacements. Each entry includes a `NodeLogicalId` that can be used to
    /// track the node's provisioning status (with `DescribeClusterNode`), the
    /// instance group name, and the current status of the node.
    successful: ?[]const NodeAdditionResult = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchAddClusterNodesInput, options: Options) !BatchAddClusterNodesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: BatchAddClusterNodesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.BatchAddClusterNodes");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !BatchAddClusterNodesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchAddClusterNodesOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
