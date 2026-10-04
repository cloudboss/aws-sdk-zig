const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const VerifyDomainIdentityInput = struct {
    /// The domain to be verified.
    domain: []const u8,
};

pub const VerifyDomainIdentityOutput = struct {
    /// A TXT record that you must place in the DNS settings of the domain to
    /// complete domain
    /// verification with Amazon SES.
    ///
    /// As Amazon SES searches for the TXT record, the domain's verification status
    /// is "Pending".
    /// When Amazon SES detects the record, the domain's verification status changes
    /// to "Success". If
    /// Amazon SES is unable to detect the record within 72 hours, the domain's
    /// verification status
    /// changes to "Failed." In that case, to verify the domain, you must restart
    /// the
    /// verification process from the beginning. The domain's verification status
    /// also changes
    /// to "Success" when it is DKIM verified.
    verification_token: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyDomainIdentityInput, options: CallOptions) !VerifyDomainIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyDomainIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=VerifyDomainIdentity&Version=2010-12-01");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyDomainIdentityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VerifyDomainIdentityResult")) break;
            },
            else => {},
        }
    }

    var result: VerifyDomainIdentityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VerificationToken")) {
                    result.verification_token = try allocator.dupe(u8, try reader.readElementText());
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
