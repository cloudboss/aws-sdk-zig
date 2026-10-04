const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VolumeAttachmentStatus = @import("volume_attachment_status.zig").VolumeAttachmentStatus;

pub const DetachClusterNodeVolumeInput = struct {
    /// The Amazon Resource Name (ARN) of your SageMaker HyperPod cluster containing
    /// the target node. Your cluster must use EKS as the orchestration and be in
    /// the `InService` state.
    cluster_arn: []const u8,

    /// The unique identifier of the cluster node from which you want to detach the
    /// volume.
    node_id: []const u8,

    /// The unique identifier of your EBS volume that you want to detach. Your
    /// volume must be currently attached to the specified node.
    volume_id: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .node_id = "NodeId",
        .volume_id = "VolumeId",
    };
};

pub const DetachClusterNodeVolumeOutput = struct {
    /// The original timestamp when your volume was initially attached to the node.
    attach_time: i64,

    /// The Amazon Resource Name (ARN) of your SageMaker HyperPod cluster where the
    /// volume detachment operation was performed.
    cluster_arn: []const u8,

    /// The device name assigned to your attached volume on the target instance.
    device_name: []const u8,

    /// The unique identifier of the cluster node from which your volume was
    /// detached.
    node_id: []const u8,

    /// The current status of your volume detachment operation.
    status: VolumeAttachmentStatus,

    /// The unique identifier of your EBS volume that was detached.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachClusterNodeVolumeInput, options: CallOptions) !DetachClusterNodeVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachClusterNodeVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DetachClusterNodeVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachClusterNodeVolumeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DetachClusterNodeVolumeOutput, body, allocator);
}
