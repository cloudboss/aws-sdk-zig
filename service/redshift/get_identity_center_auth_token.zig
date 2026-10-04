const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetIdentityCenterAuthTokenInput = struct {
    /// A list of cluster identifiers that the generated token can be used with.
    /// The token will be scoped to only allow authentication to the specified
    /// clusters.
    ///
    /// Constraints:
    ///
    /// * `ClusterIds` must contain at least 1 cluster identifier.
    ///
    /// * `ClusterIds` can hold a maximum of 20 cluster identifiers.
    ///
    /// * Cluster identifiers must be 1 to 63 characters in length.
    ///
    /// * The characters accepted for cluster identifiers are the following:
    ///
    /// * Alphanumeric characters
    ///
    /// * Hyphens
    ///
    /// * Cluster identifiers must start with a letter.
    ///
    /// * Cluster identifiers can't end with a hyphen or contain two consecutive
    ///   hyphens.
    cluster_ids: []const []const u8,
};

pub const GetIdentityCenterAuthTokenOutput = struct {
    /// The time (UTC) when the token expires. After this timestamp,
    /// the token will no longer be valid for authentication.
    expiration_time: ?i64 = null,

    /// The encrypted authentication token containing the caller's Amazon Web
    /// Services IAM Identity Center identity information.
    /// This token is encrypted using Key Management Service and can only be
    /// decrypted by the specified Amazon Redshift clusters.
    /// Use this token with Amazon Redshift drivers to authenticate using your
    /// Amazon Web Services IAM Identity Center identity.
    token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityCenterAuthTokenInput, options: CallOptions) !GetIdentityCenterAuthTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityCenterAuthTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetIdentityCenterAuthToken&Version=2012-12-01");
    for (input.cluster_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ClusterIds.ClusterIdentifier.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityCenterAuthTokenOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetIdentityCenterAuthTokenResult")) break;
            },
            else => {},
        }
    }

    var result: GetIdentityCenterAuthTokenOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExpirationTime")) {
                    result.expiration_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Token")) {
                    result.token = try allocator.dupe(u8, try reader.readElementText());
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
