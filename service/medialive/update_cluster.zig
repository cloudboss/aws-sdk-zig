const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterNetworkSettingsUpdateRequest = @import("cluster_network_settings_update_request.zig").ClusterNetworkSettingsUpdateRequest;
const ClusterType = @import("cluster_type.zig").ClusterType;
const ClusterNetworkSettings = @import("cluster_network_settings.zig").ClusterNetworkSettings;
const ClusterState = @import("cluster_state.zig").ClusterState;

pub const UpdateClusterInput = struct {
    /// The ID of the cluster
    cluster_id: []const u8,

    /// Include this parameter only if you want to change the current name of the
    /// Cluster. Specify a name that is unique in the AWS account. You can't change
    /// the name. Names are case-sensitive.
    name: ?[]const u8 = null,

    /// Include this property only if you want to change the current connections
    /// between the Nodes in the Cluster and the Networks the Cluster is associated
    /// with.
    network_settings: ?ClusterNetworkSettingsUpdateRequest = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .name = "Name",
        .network_settings = "NetworkSettings",
    };
};

pub const UpdateClusterOutput = struct {
    /// The ARN of the Cluster.
    arn: ?[]const u8 = null,

    /// An array of the IDs of the Channels that are associated with this Cluster.
    /// One Channel is associated with the Cluster as follows: A Channel belongs to
    /// a ChannelPlacementGroup. A ChannelPlacementGroup is attached to a Node. A
    /// Node belongs to a Cluster.
    channel_ids: ?[]const []const u8 = null,

    /// The hardware type for the Cluster
    cluster_type: ?ClusterType = null,

    /// The unique ID of the Cluster.
    id: ?[]const u8 = null,

    /// The user-specified name of the Cluster.
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
        .name = "Name",
        .network_settings = "NetworkSettings",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: CallOptions) !UpdateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NetworkSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    const result: UpdateClusterOutput = try aws.json.parseJsonObject(
        UpdateClusterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
