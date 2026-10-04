const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutDedicatedIpWarmupAttributesInput = struct {
    /// The dedicated IP address that you want to update the warm-up attributes for.
    ip: []const u8,

    /// The warm-up percentage that you want to associate with the dedicated IP
    /// address.
    warmup_percentage: i32,

    pub const json_field_names = .{
        .ip = "Ip",
        .warmup_percentage = "WarmupPercentage",
    };
};

pub const PutDedicatedIpWarmupAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDedicatedIpWarmupAttributesInput, options: CallOptions) !PutDedicatedIpWarmupAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDedicatedIpWarmupAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/dedicated-ips/");
    try path_buf.appendSlice(allocator, input.ip);
    try path_buf.appendSlice(allocator, "/warmup");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WarmupPercentage\":");
    try aws.json.writeValue(@TypeOf(input.warmup_percentage), input.warmup_percentage, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDedicatedIpWarmupAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutDedicatedIpWarmupAttributesOutput = .{};

    return result;
}
