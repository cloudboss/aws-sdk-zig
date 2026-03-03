const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const DirectConnectGatewayAssociation = @import("direct_connect_gateway_association.zig").DirectConnectGatewayAssociation;

pub const CreateDirectConnectGatewayAssociationInput = struct {
    /// The Amazon VPC prefixes to advertise to the Direct Connect gateway
    ///
    /// This parameter is required when you create an association to a transit
    /// gateway.
    ///
    /// For information about how to set the prefixes, see [Allowed
    /// Prefixes](https://docs.aws.amazon.com/directconnect/latest/UserGuide/multi-account-associate-vgw.html#allowed-prefixes) in the *Direct Connect User Guide*.
    add_allowed_prefixes_to_direct_connect_gateway: ?[]const RouteFilterPrefix = null,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: []const u8,

    /// The ID of the virtual private gateway or transit gateway.
    gateway_id: ?[]const u8 = null,

    /// The ID of the virtual private gateway.
    virtual_gateway_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .add_allowed_prefixes_to_direct_connect_gateway = "addAllowedPrefixesToDirectConnectGateway",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .gateway_id = "gatewayId",
        .virtual_gateway_id = "virtualGatewayId",
    };
};

pub const CreateDirectConnectGatewayAssociationOutput = struct {
    /// The association to be created.
    direct_connect_gateway_association: ?DirectConnectGatewayAssociation = null,

    pub const json_field_names = .{
        .direct_connect_gateway_association = "directConnectGatewayAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDirectConnectGatewayAssociationInput, options: CallOptions) !CreateDirectConnectGatewayAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "directconnect");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDirectConnectGatewayAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.CreateDirectConnectGatewayAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDirectConnectGatewayAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDirectConnectGatewayAssociationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DirectConnectClientException")) {
        return .{ .arena = arena, .kind = .{ .direct_connect_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectConnectServerException")) {
        return .{ .arena = arena, .kind = .{ .direct_connect_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
