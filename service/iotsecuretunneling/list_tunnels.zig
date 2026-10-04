const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TunnelSummary = @import("tunnel_summary.zig").TunnelSummary;

pub const ListTunnelsInput = struct {
    /// The maximum number of results to return at once.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the nextToken value from a previous
    /// response;
    /// otherwise null to receive the first set of results.
    next_token: ?[]const u8 = null,

    /// The name of the IoT thing associated with the destination device.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .thing_name = "thingName",
    };
};

pub const ListTunnelsOutput = struct {
    /// The token to use to get the next set of results, or null if there are no
    /// additional
    /// results.
    next_token: ?[]const u8 = null,

    /// A short description of the tunnels in an Amazon Web Services account.
    tunnel_summaries: ?[]const TunnelSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tunnel_summaries = "tunnelSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTunnelsInput, options: CallOptions) !ListTunnelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsecuredtunneling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTunnelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.tunneling.iot", "IoTSecureTunneling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IoTSecuredTunneling.ListTunnels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTunnelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTunnelsOutput, body, allocator);
}
