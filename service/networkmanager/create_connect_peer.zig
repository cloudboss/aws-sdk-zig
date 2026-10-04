const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BgpOptions = @import("bgp_options.zig").BgpOptions;
const Tag = @import("tag.zig").Tag;
const ConnectPeer = @import("connect_peer.zig").ConnectPeer;

pub const CreateConnectPeerInput = struct {
    /// The Connect peer BGP options. This only applies only when the protocol is
    /// `GRE`.
    bgp_options: ?BgpOptions = null,

    /// The client token associated with the request.
    client_token: ?[]const u8 = null,

    /// The ID of the connection attachment.
    connect_attachment_id: []const u8,

    /// A Connect peer core network address. This only applies only when the
    /// protocol is `GRE`.
    core_network_address: ?[]const u8 = null,

    /// The inside IP addresses used for BGP peering.
    inside_cidr_blocks: ?[]const []const u8 = null,

    /// The Connect peer address.
    peer_address: []const u8,

    /// The subnet ARN for the Connect peer. This only applies only when the
    /// protocol is NO_ENCAP.
    subnet_arn: ?[]const u8 = null,

    /// The tags associated with the peer request.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bgp_options = "BgpOptions",
        .client_token = "ClientToken",
        .connect_attachment_id = "ConnectAttachmentId",
        .core_network_address = "CoreNetworkAddress",
        .inside_cidr_blocks = "InsideCidrBlocks",
        .peer_address = "PeerAddress",
        .subnet_arn = "SubnetArn",
        .tags = "Tags",
    };
};

pub const CreateConnectPeerOutput = struct {
    /// The response to the request.
    connect_peer: ?ConnectPeer = null,

    pub const json_field_names = .{
        .connect_peer = "ConnectPeer",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectPeerInput, options: CallOptions) !CreateConnectPeerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectPeerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connect-peers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bgp_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BgpOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectAttachmentId\":");
    try aws.json.writeValue(@TypeOf(input.connect_attachment_id), input.connect_attachment_id, allocator, &body_buf);
    has_prev = true;
    if (input.core_network_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CoreNetworkAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inside_cidr_blocks) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InsideCidrBlocks\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PeerAddress\":");
    try aws.json.writeValue(@TypeOf(input.peer_address), input.peer_address, allocator, &body_buf);
    has_prev = true;
    if (input.subnet_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubnetArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectPeerOutput {
    var result: CreateConnectPeerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectPeerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
