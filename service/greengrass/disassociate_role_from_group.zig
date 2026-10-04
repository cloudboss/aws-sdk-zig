const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateRoleFromGroupInput = struct {
    /// The ID of the Greengrass group.
    group_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
    };
};

pub const DisassociateRoleFromGroupOutput = struct {
    /// The time, in milliseconds since the epoch, when the role was disassociated
    /// from the group.
    disassociated_at: ?[]const u8 = null,

    pub const json_field_names = .{
        .disassociated_at = "DisassociatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateRoleFromGroupInput, options: CallOptions) !DisassociateRoleFromGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateRoleFromGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    try path_buf.appendSlice(allocator, "/role");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateRoleFromGroupOutput {
    var result: DisassociateRoleFromGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DisassociateRoleFromGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
