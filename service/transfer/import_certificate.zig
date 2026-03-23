const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const CertificateUsageType = @import("certificate_usage_type.zig").CertificateUsageType;

pub const ImportCertificateInput = struct {
    /// An optional date that specifies when the certificate becomes active. If you
    /// do not specify a value, `ActiveDate` takes the same value as
    /// `NotBeforeDate`, which is specified by the CA.
    active_date: ?i64 = null,

    /// * For the CLI, provide a file path for a certificate in URI format. For
    ///   example, `--certificate file://encryption-cert.pem`. Alternatively, you
    ///   can provide the raw content.
    /// * For the SDK, specify the raw content of a certificate file. For example,
    ///   `--certificate "`cat encryption-cert.pem`"`.
    ///
    /// You can provide both the certificate and its chain in this parameter,
    /// without needing to use the `CertificateChain` parameter. If you use this
    /// parameter for both the certificate and its chain, do not use the
    /// `CertificateChain` parameter.
    certificate: []const u8,

    /// An optional list of certificates that make up the chain for the certificate
    /// that's being imported.
    certificate_chain: ?[]const u8 = null,

    /// A short description that helps identify the certificate.
    description: ?[]const u8 = null,

    /// An optional date that specifies when the certificate becomes inactive. If
    /// you do not specify a value, `InactiveDate` takes the same value as
    /// `NotAfterDate`, which is specified by the CA.
    inactive_date: ?i64 = null,

    /// * For the CLI, provide a file path for a private key in URI format. For
    ///   example, `--private-key file://encryption-key.pem`. Alternatively, you can
    ///   provide the raw content of the private key file.
    /// * For the SDK, specify the raw content of a private key file. For example,
    ///   `--private-key "`cat encryption-key.pem`"`
    private_key: ?[]const u8 = null,

    /// Key-value pairs that can be used to group and search for certificates.
    tags: ?[]const Tag = null,

    /// Specifies how this certificate is used. It can be used in the following
    /// ways:
    ///
    /// * `SIGNING`: For signing AS2 messages
    /// * `ENCRYPTION`: For encrypting AS2 messages
    /// * `TLS`: For securing AS2 communications sent over HTTPS
    usage: CertificateUsageType,

    pub const json_field_names = .{
        .active_date = "ActiveDate",
        .certificate = "Certificate",
        .certificate_chain = "CertificateChain",
        .description = "Description",
        .inactive_date = "InactiveDate",
        .private_key = "PrivateKey",
        .tags = "Tags",
        .usage = "Usage",
    };
};

pub const ImportCertificateOutput = struct {
    /// An array of identifiers for the imported certificates. You use this
    /// identifier for working with profiles and partner profiles.
    certificate_id: []const u8,

    pub const json_field_names = .{
        .certificate_id = "CertificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCertificateInput, options: CallOptions) !ImportCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transfer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ImportCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCertificateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportCertificateOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
