const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VolumeAttachmentStatus = @import("volume_attachment_status.zig").VolumeAttachmentStatus;

pub const AttachClusterNodeVolumeInput = struct {
    /// The Amazon Resource Name (ARN) of your SageMaker HyperPod cluster containing
    /// the target node. Your cluster must use EKS as the orchestration and be in
    /// the `InService` state.
    cluster_arn: []const u8,

    /// The unique identifier of the cluster node to which you want to attach the
    /// volume. The node must belong to your specified HyperPod cluster and cannot
    /// be part of a Restricted Instance Group (RIG).
    node_id: []const u8,

    /// The unique identifier of your EBS volume to attach. The volume must be in
    /// the `available` state.
    volume_id: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .node_id = "NodeId",
        .volume_id = "VolumeId",
    };
};

pub const AttachClusterNodeVolumeOutput = struct {
    /// The timestamp when the volume attachment operation was initiated by the
    /// SageMaker HyperPod service.
    attach_time: i64,

    /// The Amazon Resource Name (ARN) of your SageMaker HyperPod cluster where the
    /// volume attachment operation was performed.
    cluster_arn: []const u8,

    /// The device name assigned to your attached volume on the target instance.
    device_name: []const u8,

    /// The unique identifier of the cluster node where your volume was attached.
    node_id: []const u8,

    /// The current status of your volume attachment operation.
    status: VolumeAttachmentStatus,

    /// The unique identifier of your EBS volume that was attached.
    volume_id: []const u8,

    pub const json_field_names = .{
        .attach_time = "AttachTime",
        .cluster_arn = "ClusterArn",
        .device_name = "DeviceName",
        .node_id = "NodeId",
        .status = "Status",
        .volume_id = "VolumeId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachClusterNodeVolumeInput, options: Options) !AttachClusterNodeVolumeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AttachClusterNodeVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.AttachClusterNodeVolume");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AttachClusterNodeVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AttachClusterNodeVolumeOutput, body, alloc);
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
