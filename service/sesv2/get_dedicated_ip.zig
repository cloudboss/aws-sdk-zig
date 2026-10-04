const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DedicatedIp = @import("dedicated_ip.zig").DedicatedIp;

pub const GetDedicatedIpInput = struct {
    /// The IP address that you want to obtain more information about. The value you
    /// specify
    /// has to be a dedicated IP address that's assocaited with your Amazon Web
    /// Services account.
    ip: []const u8,

    pub const json_field_names = .{
        .ip = "Ip",
    };
};

pub const GetDedicatedIpOutput = struct {
    /// An object that contains information about a dedicated IP address.
    dedicated_ip: ?DedicatedIp = null,

    pub const json_field_names = .{
        .dedicated_ip = "DedicatedIp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDedicatedIpInput, options: CallOptions) !GetDedicatedIpOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDedicatedIpInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/dedicated-ips/");
    try path_buf.appendSlice(allocator, input.ip);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDedicatedIpOutput {
    var result: GetDedicatedIpOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDedicatedIpOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
