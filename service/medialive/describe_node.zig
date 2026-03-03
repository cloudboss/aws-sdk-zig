const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NodeConnectionState = @import("node_connection_state.zig").NodeConnectionState;
const NodeInterfaceMapping = @import("node_interface_mapping.zig").NodeInterfaceMapping;
const NodeRole = @import("node_role.zig").NodeRole;
const SdiSourceMapping = @import("sdi_source_mapping.zig").SdiSourceMapping;
const NodeState = @import("node_state.zig").NodeState;

pub const DescribeNodeInput = struct {
    /// The ID of the cluster
    cluster_id: []const u8,

    /// The ID of the node.
    node_id: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .node_id = "NodeId",
    };
};

pub const DescribeNodeOutput = struct {
    /// The ARN of the Node. It is automatically assigned when the Node is created.
    arn: ?[]const u8 = null,

    /// An array of IDs. Each ID is one ChannelPlacementGroup that is associated
    /// with this Node. Empty if the Node is not yet associated with any groups.
    channel_placement_groups: ?[]const []const u8 = null,

    /// The ID of the Cluster that the Node belongs to.
    cluster_id: ?[]const u8 = null,

    /// The current connection state of the Node.
    connection_state: ?NodeConnectionState = null,

    /// The unique ID of the Node. Unique in the Cluster. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8 = null,

    /// The ARN of the EC2 instance hosting the Node.
    instance_arn: ?[]const u8 = null,

    /// The name that you specified for the Node.
    name: ?[]const u8 = null,

    /// Documentation update needed
    node_interface_mappings: ?[]const NodeInterfaceMapping = null,

    /// The initial role current role of the Node in the Cluster. ACTIVE means the
    /// Node is available for encoding. BACKUP means the Node is a redundant Node
    /// and might get used if an ACTIVE Node fails.
    role: ?NodeRole = null,

    /// An array of SDI source mappings. Each mapping connects one logical SdiSource
    /// to the physical SDI card and port that the physical SDI source uses.
    sdi_source_mappings: ?[]const SdiSourceMapping = null,

    /// The current state of the Node.
    state: ?NodeState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_placement_groups = "ChannelPlacementGroups",
        .cluster_id = "ClusterId",
        .connection_state = "ConnectionState",
        .id = "Id",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .node_interface_mappings = "NodeInterfaceMappings",
        .role = "Role",
        .sdi_source_mappings = "SdiSourceMappings",
        .state = "State",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNodeInput, options: Options) !DescribeNodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prod/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_id);
    try path_buf.appendSlice(allocator, "/nodes/");
    try path_buf.appendSlice(allocator, input.node_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNodeOutput {
    var result: DescribeNodeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeNodeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
