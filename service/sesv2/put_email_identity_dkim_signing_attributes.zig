const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DkimSigningAttributes = @import("dkim_signing_attributes.zig").DkimSigningAttributes;
const DkimSigningAttributesOrigin = @import("dkim_signing_attributes_origin.zig").DkimSigningAttributesOrigin;
const DkimStatus = @import("dkim_status.zig").DkimStatus;

pub const PutEmailIdentityDkimSigningAttributesInput = struct {
    /// The email identity.
    email_identity: []const u8,

    /// An object that contains information about the private key and selector that
    /// you want
    /// to use to configure DKIM for the identity for Bring Your Own DKIM (BYODKIM)
    /// for the
    /// identity, or, configures the key length to be used for [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
    signing_attributes: ?DkimSigningAttributes = null,

    /// The method to use to configure DKIM for the identity. There are the
    /// following possible
    /// values:
    ///
    /// * `AWS_SES` – Configure DKIM for the identity by using [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
    ///
    /// * `EXTERNAL` – Configure DKIM for the identity by using Bring
    /// Your Own DKIM (BYODKIM).
    signing_attributes_origin: DkimSigningAttributesOrigin,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
        .signing_attributes = "SigningAttributes",
        .signing_attributes_origin = "SigningAttributesOrigin",
    };
};

pub const PutEmailIdentityDkimSigningAttributesOutput = struct {
    /// The DKIM authentication status of the identity. Amazon SES determines the
    /// authentication
    /// status by searching for specific records in the DNS configuration for your
    /// domain. If
    /// you used [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html)
    /// to set up DKIM authentication, Amazon SES tries to find three unique CNAME
    /// records in the DNS configuration for your domain.
    ///
    /// If you provided a public key to perform DKIM authentication, Amazon SES
    /// tries to find a TXT
    /// record that uses the selector that you specified. The value of the TXT
    /// record must be a
    /// public key that's paired with the private key that you specified in the
    /// process of
    /// creating the identity.
    ///
    /// The status can be one of the following:
    ///
    /// * `PENDING` – The verification process was initiated, but Amazon SES
    /// hasn't yet detected the DKIM records in the DNS configuration for the
    /// domain.
    ///
    /// * `SUCCESS` – The verification process completed
    /// successfully.
    ///
    /// * `FAILED` – The verification process failed. This typically
    /// occurs when Amazon SES fails to find the DKIM records in the DNS
    /// configuration of the
    /// domain.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
    /// from determining the DKIM authentication status of the domain.
    ///
    /// * `NOT_STARTED` – The DKIM verification process hasn't been
    /// initiated for the domain.
    dkim_status: ?DkimStatus = null,

    /// If you used [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html)
    /// to configure DKIM authentication for the domain, then this object
    /// contains a set of unique strings that you use to create a set of CNAME
    /// records that you
    /// add to the DNS configuration for your domain. When Amazon SES detects these
    /// records in the
    /// DNS configuration for your domain, the DKIM authentication process is
    /// complete.
    ///
    /// If you configured DKIM authentication for the domain by providing your own
    /// public-private key pair, then this object contains the selector that's
    /// associated with
    /// your public key.
    ///
    /// Regardless of the DKIM authentication method you use, Amazon SES searches
    /// for the
    /// appropriate records in the DNS configuration of the domain for up to 72
    /// hours.
    dkim_tokens: ?[]const []const u8 = null,

    /// The hosted zone where Amazon SES publishes the DKIM public key TXT records
    /// for this email identity.
    /// This value indicates the DNS zone that customers must reference when
    /// configuring their CNAME records for DKIM authentication.
    ///
    /// When configuring DKIM for your domain, create CNAME records in your DNS that
    /// point to the selectors in this hosted zone.
    /// For example:
    ///
    /// `
    /// selector1._domainkey.yourdomain.com CNAME selector1.
    /// `
    ///
    /// `
    /// selector2._domainkey.yourdomain.com CNAME selector2.
    /// `
    ///
    /// `
    /// selector3._domainkey.yourdomain.com CNAME selector3.
    /// `
    signing_hosted_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .dkim_status = "DkimStatus",
        .dkim_tokens = "DkimTokens",
        .signing_hosted_zone = "SigningHostedZone",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEmailIdentityDkimSigningAttributesInput, options: CallOptions) !PutEmailIdentityDkimSigningAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ses");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutEmailIdentityDkimSigningAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/email/identities/");
    try path_buf.appendSlice(allocator, input.email_identity);
    try path_buf.appendSlice(allocator, "/dkim/signing");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.signing_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SigningAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SigningAttributesOrigin\":");
    try aws.json.writeValue(@TypeOf(input.signing_attributes_origin), input.signing_attributes_origin, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEmailIdentityDkimSigningAttributesOutput {
    var result: PutEmailIdentityDkimSigningAttributesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutEmailIdentityDkimSigningAttributesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailFromDomainNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .mail_from_domain_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MessageRejected")) {
        return .{ .arena = arena, .kind = .{ .message_rejected = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
