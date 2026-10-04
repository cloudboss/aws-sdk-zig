const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AttachClusterNodeNetworkInterfaceInput = struct {
    /// The name or Amazon Resource Name (ARN) of the SageMaker HyperPod cluster
    /// that contains the target node.
    cluster_name: []const u8,

    /// The unique identifier of the elastic network interface (ENI) to attach.
    network_interface_id: []const u8,

    /// The unique identifier of the cluster node to which you want to attach the
    /// network interface. The node must belong to your specified HyperPod cluster
    /// and cannot be part of a Restricted Instance Group (RIG).
    node_id: []const u8,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .network_interface_id = "NetworkInterfaceId",
        .node_id = "NodeId",
    };
};

pub const AttachClusterNodeNetworkInterfaceOutput = struct {
    /// The unique identifier of the network interface attachment. Use this value to
    /// reference or detach the network interface later.
    attachment_id: []const u8,

    /// The Amazon Resource Name (ARN) of your SageMaker HyperPod cluster where the
    /// network interface attachment operation was performed.
    cluster_arn: []const u8,

    /// The unique identifier of the elastic network interface (ENI) that was
    /// attached.
    network_interface_id: []const u8,

    /// The unique identifier of the cluster node where your network interface was
    /// attached.
    node_id: []const u8,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .cluster_arn = "ClusterArn",
        .network_interface_id = "NetworkInterfaceId",
        .node_id = "NodeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachClusterNodeNetworkInterfaceInput, options: CallOptions) !AttachClusterNodeNetworkInterfaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachClusterNodeNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.AttachClusterNodeNetworkInterface");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachClusterNodeNetworkInterfaceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AttachClusterNodeNetworkInterfaceOutput, body, allocator);
}
