const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DedicatedIpPool = @import("dedicated_ip_pool.zig").DedicatedIpPool;

pub const GetDedicatedIpPoolInput = struct {
    /// The name of the dedicated IP pool to retrieve.
    pool_name: []const u8,

    pub const json_field_names = .{
        .pool_name = "PoolName",
    };
};

pub const GetDedicatedIpPoolOutput = struct {
    /// An object that contains information about a dedicated IP pool.
    dedicated_ip_pool: ?DedicatedIpPool = null,

    pub const json_field_names = .{
        .dedicated_ip_pool = "DedicatedIpPool",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDedicatedIpPoolInput, options: CallOptions) !GetDedicatedIpPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDedicatedIpPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/dedicated-ip-pools/");
    try path_buf.appendSlice(allocator, input.pool_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDedicatedIpPoolOutput {
    const result: GetDedicatedIpPoolOutput = try aws.json.parseJsonObject(
        GetDedicatedIpPoolOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
