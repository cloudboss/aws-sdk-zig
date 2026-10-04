const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterType = @import("cluster_type.zig").ClusterType;
const ClusterNetworkSettings = @import("cluster_network_settings.zig").ClusterNetworkSettings;
const ClusterState = @import("cluster_state.zig").ClusterState;

pub const DescribeClusterInput = struct {
    /// The ID of the cluster.
    cluster_id: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
    };
};

pub const DescribeClusterOutput = struct {
    /// The ARN of this Cluster. It is automatically assigned when the Cluster is
    /// created.
    arn: ?[]const u8 = null,

    channel_ids: ?[]const []const u8 = null,

    /// The hardware type for the Cluster
    cluster_type: ?ClusterType = null,

    /// The ID of the Cluster. Unique in the AWS account. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8 = null,

    /// The ARN of the IAM role for the Node in this Cluster. Any Nodes that are
    /// associated with this Cluster assume this role. The role gives permissions to
    /// the operations that you expect these Node to perform.
    instance_role_arn: ?[]const u8 = null,

    /// The name that you specified for the Cluster.
    name: ?[]const u8 = null,

    /// Network settings that connect the Nodes in the Cluster to one or more of the
    /// Networks that the Cluster is associated with.
    network_settings: ?ClusterNetworkSettings = null,

    /// The current state of the Cluster.
    state: ?ClusterState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_ids = "ChannelIds",
        .cluster_type = "ClusterType",
        .id = "Id",
        .instance_role_arn = "InstanceRoleArn",
        .name = "Name",
        .network_settings = "NetworkSettings",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterInput, options: CallOptions) !DescribeClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterOutput {
    const result: DescribeClusterOutput = try aws.json.parseJsonObject(
        DescribeClusterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
