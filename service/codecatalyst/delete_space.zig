const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteSpaceInput = struct {
    /// The name of the space. To retrieve a list of space names, use ListSpaces.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const DeleteSpaceOutput = struct {
    /// The friendly name of the space displayed to users of the space in Amazon
    /// CodeCatalyst.
    display_name: ?[]const u8 = null,

    /// The name of the space.
    name: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteSpaceInput, options: CallOptions) !DeleteSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteSpaceOutput {
    const result: DeleteSpaceOutput = try aws.json.parseJsonObject(
        DeleteSpaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
