const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelPlacementGroupState = @import("channel_placement_group_state.zig").ChannelPlacementGroupState;

pub const DeleteChannelPlacementGroupInput = struct {
    /// The ID of the channel placement group.
    channel_placement_group_id: []const u8,

    /// The ID of the cluster.
    cluster_id: []const u8,

    pub const json_field_names = .{
        .channel_placement_group_id = "ChannelPlacementGroupId",
        .cluster_id = "ClusterId",
    };
};

pub const DeleteChannelPlacementGroupOutput = struct {
    /// The ARN of this ChannelPlacementGroup. It is automatically assigned when the
    /// ChannelPlacementGroup is created.
    arn: ?[]const u8 = null,

    /// Used in ListChannelPlacementGroupsResult
    channels: ?[]const []const u8 = null,

    /// The ID of the Cluster that the Node belongs to.
    cluster_id: ?[]const u8 = null,

    /// The ID of the ChannelPlacementGroup. Unique in the AWS account. The ID is
    /// the resource-id portion of the ARN.
    id: ?[]const u8 = null,

    /// The name that you specified for the ChannelPlacementGroup.
    name: ?[]const u8 = null,

    /// An array with one item, which is the single Node that is associated with the
    /// ChannelPlacementGroup.
    nodes: ?[]const []const u8 = null,

    /// The current state of the ChannelPlacementGroup.
    state: ?ChannelPlacementGroupState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channels = "Channels",
        .cluster_id = "ClusterId",
        .id = "Id",
        .name = "Name",
        .nodes = "Nodes",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteChannelPlacementGroupInput, options: CallOptions) !DeleteChannelPlacementGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteChannelPlacementGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_id);
    try path_buf.appendSlice(allocator, "/channelplacementgroups/");
    try path_buf.appendSlice(allocator, input.channel_placement_group_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteChannelPlacementGroupOutput {
    var result: DeleteChannelPlacementGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteChannelPlacementGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
