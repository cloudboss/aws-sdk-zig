const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const VirtualInterface = @import("virtual_interface.zig").VirtualInterface;

pub const DeleteBGPPeerInput = struct {
    /// The autonomous system number (ASN). The valid range is from 1 to 2147483646
    /// for Border Gateway Protocol (BGP) configuration. If you provide a number
    /// greater than the maximum, an error is returned. Use `asnLong` instead.
    ///
    /// You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    /// as it supports a greater pool of numbers.
    ///
    /// * The `asnLong` attribute accepts both ASN and long ASN
    /// ranges.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn: ?i32 = null,

    /// The long ASN for the BGP peer to be deleted from a Direct Connect virtual
    /// interface. The valid range is from 1 to 4294967294 for BGP configuration.
    ///
    /// You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    /// as it supports a greater pool of numbers.
    ///
    /// * The `asnLong` attribute accepts both ASN and long ASN
    /// ranges.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn_long: ?i64 = null,

    /// The ID of the BGP peer.
    bgp_peer_id: ?[]const u8 = null,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8 = null,

    /// The ID of the virtual interface.
    virtual_interface_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .asn = "asn",
        .asn_long = "asnLong",
        .bgp_peer_id = "bgpPeerId",
        .customer_address = "customerAddress",
        .virtual_interface_id = "virtualInterfaceId",
    };
};

pub const DeleteBGPPeerOutput = struct {
    /// The virtual interface.
    virtual_interface: ?VirtualInterface = null,

    pub const json_field_names = .{
        .virtual_interface = "virtualInterface",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBGPPeerInput, options: CallOptions) !DeleteBGPPeerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBGPPeerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.DeleteBGPPeer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBGPPeerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBGPPeerOutput, body, allocator);
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
