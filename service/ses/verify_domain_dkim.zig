const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const VerifyDomainDkimInput = struct {
    /// The name of the domain to be verified for Easy DKIM signing.
    domain: []const u8,
};

pub const VerifyDomainDkimOutput = struct {
    /// A set of character strings that represent the domain's identity. If the
    /// identity is an
    /// email address, the tokens represent the domain of that address.
    ///
    /// Using these tokens, you need to create DNS CNAME records that point to DKIM
    /// public
    /// keys that are hosted by Amazon SES. Amazon Web Services eventually detects
    /// that you've updated your DNS
    /// records. This detection process might take up to 72 hours. After successful
    /// detection,
    /// Amazon SES is able to DKIM-sign email originating from that domain. (This
    /// only applies to
    /// domain identities, not email address identities.)
    ///
    /// For more information about creating DNS records using DKIM tokens, see the
    /// [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-easy.html).
    dkim_tokens: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyDomainDkimInput, options: CallOptions) !VerifyDomainDkimOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyDomainDkimInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=VerifyDomainDkim&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Domain=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyDomainDkimOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VerifyDomainDkimResult")) break;
            },
            else => {},
        }
    }

    var result: VerifyDomainDkimOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DkimTokens")) {
                    result.dkim_tokens = try serde.deserializeVerificationTokenList(allocator, &reader, "member");
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
