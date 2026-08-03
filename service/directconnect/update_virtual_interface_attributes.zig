const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AddressFamily = @import("address_family.zig").AddressFamily;
const BGPPeer = @import("bgp_peer.zig").BGPPeer;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const Tag = @import("tag.zig").Tag;
const VirtualInterfaceState = @import("virtual_interface_state.zig").VirtualInterfaceState;

pub const UpdateVirtualInterfaceAttributesInput = struct {
    /// Indicates whether to enable or disable SiteLink.
    enable_site_link: ?bool = null,

    /// The maximum transmission unit (MTU), in bytes. The supported values are 1500
    /// and 8500. The default value is 1500.
    mtu: ?i32 = null,

    /// The ID of the virtual private interface.
    virtual_interface_id: []const u8,

    /// The name of the virtual private interface.
    virtual_interface_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_site_link = "enableSiteLink",
        .mtu = "mtu",
        .virtual_interface_id = "virtualInterfaceId",
        .virtual_interface_name = "virtualInterfaceName",
    };
};

pub const UpdateVirtualInterfaceAttributesOutput = @import("virtual_interface.zig").VirtualInterface;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVirtualInterfaceAttributesInput, options: CallOptions) !UpdateVirtualInterfaceAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVirtualInterfaceAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.UpdateVirtualInterfaceAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVirtualInterfaceAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateVirtualInterfaceAttributesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.DirectConnectClientException = aws.json.parseJsonObject(errors.DirectConnectClientException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .direct_connect_client_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectConnectServerException")) {
        const parsed_error: ?errors.DirectConnectServerException = aws.json.parseJsonObject(errors.DirectConnectServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .direct_connect_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        const parsed_error: ?errors.DuplicateTagKeysException = aws.json.parseJsonObject(errors.DuplicateTagKeysException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
