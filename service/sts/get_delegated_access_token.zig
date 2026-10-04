const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

pub const GetDelegatedAccessTokenInput = struct {
    /// The token to exchange for temporary Amazon Web Services credentials. This
    /// token must be valid and
    /// unexpired at the time of the request.
    trade_in_token: []const u8,
};

pub const GetDelegatedAccessTokenOutput = struct {
    /// The Amazon Resource Name (ARN) of the principal that was assumed when
    /// obtaining the
    /// delegated access token. This ARN identifies the IAM entity whose permissions
    /// are granted
    /// by the temporary credentials.
    assumed_principal: ?[]const u8 = null,

    credentials: ?Credentials = null,

    /// The percentage of the maximum policy size that is used by the session
    /// policy. The policy
    /// size is calculated as the sum of all the session policies and permission
    /// boundaries
    /// attached to the session. If the packed size exceeds 100%, the request fails.
    packed_policy_size: ?i32 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDelegatedAccessTokenInput, options: CallOptions) !GetDelegatedAccessTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDelegatedAccessTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetDelegatedAccessToken&Version=2011-06-15");
    try body_buf.appendSlice(allocator, "&TradeInToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.trade_in_token);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDelegatedAccessTokenOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetDelegatedAccessTokenResult")) break;
            },
            else => {},
        }
    }

    var result: GetDelegatedAccessTokenOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumedPrincipal")) {
                    result.assumed_principal = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
