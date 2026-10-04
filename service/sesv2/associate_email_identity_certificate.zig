const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateEmailIdentityCertificateInput = struct {
    /// The Amazon Resource Name (ARN) of the Certificate Manager (ACM) certificate
    /// to
    /// associate with the email identity.
    certificate_arn: []const u8,

    /// The email identity, either an email address or a domain, to associate the
    /// certificate
    /// with.
    email_identity: []const u8,

    /// The email address that the certificate applies to. This value is required
    /// when the
    /// email identity is a domain, and the address must belong to that domain or
    /// one of its
    /// subdomains. When the email identity is an email address, this value is
    /// optional. If you
    /// specify it, it must exactly match the email identity.
    from_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .email_identity = "EmailIdentity",
        .from_address = "FromAddress",
    };
};

pub const AssociateEmailIdentityCertificateOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateEmailIdentityCertificateInput, options: CallOptions) !AssociateEmailIdentityCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateEmailIdentityCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/identity/certificates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CertificateArn\":");
    try aws.json.writeValue(@TypeOf(input.certificate_arn), input.certificate_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailIdentity\":");
    try aws.json.writeValue(@TypeOf(input.email_identity), input.email_identity, allocator, &body_buf);
    has_prev = true;
    if (input.from_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FromAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateEmailIdentityCertificateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateEmailIdentityCertificateOutput = .{};

    return result;
}
