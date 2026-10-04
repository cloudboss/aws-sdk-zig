const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutAccountDedicatedIpWarmupAttributesInput = struct {
    /// Enables or disables the automatic warm-up feature for dedicated IP addresses
    /// that are
    /// associated with your Amazon SES account in the current Amazon Web Services
    /// Region. Set to `true`
    /// to enable the automatic warm-up feature, or set to `false` to disable
    /// it.
    auto_warmup_enabled: ?bool = null,

    pub const json_field_names = .{
        .auto_warmup_enabled = "AutoWarmupEnabled",
    };
};

pub const PutAccountDedicatedIpWarmupAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountDedicatedIpWarmupAttributesInput, options: CallOptions) !PutAccountDedicatedIpWarmupAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountDedicatedIpWarmupAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/account/dedicated-ips/warmup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_warmup_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoWarmupEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountDedicatedIpWarmupAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutAccountDedicatedIpWarmupAttributesOutput = .{};

    return result;
}
