const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetIdentityDkimEnabledInput = struct {
    /// Sets whether DKIM signing is enabled for an identity. Set to `true` to
    /// enable DKIM signing for this identity; `false` to disable it.
    dkim_enabled: ?bool = null,

    /// The identity for which DKIM signing should be enabled or disabled.
    identity: []const u8,
};

pub const SetIdentityDkimEnabledOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityDkimEnabledInput, options: CallOptions) !SetIdentityDkimEnabledOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityDkimEnabledInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIdentityDkimEnabled&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&DkimEnabled=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.dkim_enabled) "true" else "false");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityDkimEnabledOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetIdentityDkimEnabledOutput = .{};

    return result;
}
