const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetOpentdfConfigInput = struct {
    /// The ID of the Wickr network for which OpenTDF integration will be retrieved.
    network_id: []const u8,

    pub const json_field_names = .{
        .network_id = "networkId",
    };
};

pub const GetOpentdfConfigOutput = struct {
    /// The OIDC client ID used for authenticating with the OpenTDF provider.
    client_id: []const u8,

    /// The OIDC client secret used for authenticating with the OpenTDF provider.
    client_secret: []const u8,

    /// The domain of the OpenTDF server.
    domain: []const u8,

    /// The provider of the OpenTDF platform.
    provider: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .domain = "domain",
        .provider = "provider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOpentdfConfigInput, options: CallOptions) !GetOpentdfConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOpentdfConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/tdf");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOpentdfConfigOutput {
    const result: GetOpentdfConfigOutput = try aws.json.parseJsonObject(
        GetOpentdfConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
