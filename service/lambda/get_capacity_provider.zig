const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const GetCapacityProviderInput = struct {
    /// The name of the capacity provider to retrieve.
    capacity_provider_name: []const u8,

    pub const json_field_names = .{
        .capacity_provider_name = "CapacityProviderName",
    };
};

pub const GetCapacityProviderOutput = struct {
    /// Information about the capacity provider, including its configuration and
    /// current state.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "CapacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapacityProviderInput, options: CallOptions) !GetCapacityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-11-30/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapacityProviderOutput {
    var result: GetCapacityProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCapacityProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
