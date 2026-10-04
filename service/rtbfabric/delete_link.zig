const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkStatus = @import("link_status.zig").LinkStatus;

pub const DeleteLinkInput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
        .link_id = "linkId",
    };
};

pub const DeleteLinkOutput = struct {
    /// The unique identifier of the link.
    link_id: []const u8,

    /// The status of the link.
    status: LinkStatus,

    pub const json_field_names = .{
        .link_id = "linkId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLinkInput, options: CallOptions) !DeleteLinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rtbfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/link/");
    try path_buf.appendSlice(allocator, input.link_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLinkOutput {
    var result: DeleteLinkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteLinkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
