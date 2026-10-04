const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetOutboundWebIdentityFederationInfoInput = struct {};

pub const GetOutboundWebIdentityFederationInfoOutput = struct {
    /// A unique issuer URL for your Amazon Web Services account that hosts the
    /// OpenID Connect (OIDC) discovery endpoints at
    /// `/.well-known/openid-configuration and /.well-known/jwks.json`. The OpenID
    /// Connect (OIDC) discovery endpoints contain verification keys and metadata
    /// necessary for token verification.
    issuer_identifier: ?[]const u8 = null,

    /// Indicates whether outbound identity federation is currently enabled for your
    /// Amazon Web Services account. When true, IAM principals in the account can
    /// call the `GetWebIdentityToken` API to obtain JSON Web Tokens (JWTs) for
    /// authentication with external services.
    jwt_vending_enabled: ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOutboundWebIdentityFederationInfoInput, options: CallOptions) !GetOutboundWebIdentityFederationInfoOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOutboundWebIdentityFederationInfoInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetOutboundWebIdentityFederationInfo&Version=2010-05-08");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOutboundWebIdentityFederationInfoOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetOutboundWebIdentityFederationInfoResult")) break;
            },
            else => {},
        }
    }

    var result: GetOutboundWebIdentityFederationInfoOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IssuerIdentifier")) {
                    result.issuer_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JwtVendingEnabled")) {
                    result.jwt_vending_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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
