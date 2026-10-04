const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityCertificate = @import("identity_certificate.zig").IdentityCertificate;

pub const ListEmailIdentityCertificatesInput = struct {
    /// The email identity whose certificate associations you want to list.
    email_identity: []const u8,

    /// A token returned from a previous call to `ListEmailIdentityCertificates` to
    /// indicate the position in the list of certificates.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to
    /// `ListEmailIdentityCertificates`. If the number of results is larger than the
    /// number you specified in this parameter, then the response includes a
    /// `NextToken` element, which you can use to obtain additional results.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListEmailIdentityCertificatesOutput = struct {
    /// An array that contains the certificate associations for the email identity.
    /// Each entry
    /// includes the from address, the certificate's status, its Amazon Resource
    /// Name (ARN),
    /// and its expiry time.
    certificates: ?[]const IdentityCertificate = null,

    /// A token that indicates that there are additional certificates to list. To
    /// view
    /// additional certificates, issue another request to
    /// `ListEmailIdentityCertificates`, and pass this token in the
    /// `NextToken` parameter.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificates = "Certificates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEmailIdentityCertificatesInput, options: CallOptions) !ListEmailIdentityCertificatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEmailIdentityCertificatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/identity/certificates/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailIdentity\":");
    try aws.json.writeValue(@TypeOf(input.email_identity), input.email_identity, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.page_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PageSize\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEmailIdentityCertificatesOutput {
    const result: ListEmailIdentityCertificatesOutput = try aws.json.parseJsonObject(
        ListEmailIdentityCertificatesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
