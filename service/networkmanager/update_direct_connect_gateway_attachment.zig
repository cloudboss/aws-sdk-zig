const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectConnectGatewayAttachment = @import("direct_connect_gateway_attachment.zig").DirectConnectGatewayAttachment;

pub const UpdateDirectConnectGatewayAttachmentInput = struct {
    /// The ID of the Direct Connect gateway attachment for the updated edge
    /// locations.
    attachment_id: []const u8,

    /// One or more edge locations to update for the Direct Connect gateway
    /// attachment. The updated array of edge locations overwrites the previous
    /// array of locations. `EdgeLocations` is only used for Direct Connect gateway
    /// attachments.
    edge_locations: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .edge_locations = "EdgeLocations",
    };
};

pub const UpdateDirectConnectGatewayAttachmentOutput = struct {
    /// Returns details of the Direct Connect gateway attachment with the updated
    /// edge locations.
    direct_connect_gateway_attachment: ?DirectConnectGatewayAttachment = null,

    pub const json_field_names = .{
        .direct_connect_gateway_attachment = "DirectConnectGatewayAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDirectConnectGatewayAttachmentInput, options: CallOptions) !UpdateDirectConnectGatewayAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDirectConnectGatewayAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/direct-connect-gateway-attachments/");
    try path_buf.appendSlice(allocator, input.attachment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.edge_locations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EdgeLocations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDirectConnectGatewayAttachmentOutput {
    const result: UpdateDirectConnectGatewayAttachmentOutput = try aws.json.parseJsonObject(
        UpdateDirectConnectGatewayAttachmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
