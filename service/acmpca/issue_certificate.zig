const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ApiPassthrough = @import("api_passthrough.zig").ApiPassthrough;
const SigningAlgorithm = @import("signing_algorithm.zig").SigningAlgorithm;
const Validity = @import("validity.zig").Validity;

pub const IssueCertificateInput = struct {
    /// Specifies X.509 certificate information to be included in the issued
    /// certificate. An `APIPassthrough` or `APICSRPassthrough` template variant
    /// must be selected, or else this parameter is ignored. For more information
    /// about using these templates, see [Understanding Certificate
    /// Templates](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html).
    ///
    /// If conflicting or duplicate certificate information is supplied during
    /// certificate issuance, Amazon Web Services Private CA applies [order of
    /// operation
    /// rules](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html#template-order-of-operations) to determine what information is used.
    api_passthrough: ?ApiPassthrough = null,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html). This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `
    certificate_authority_arn: []const u8,

    /// The certificate signing request (CSR) for the certificate you want to issue.
    /// As an example, you can use the following OpenSSL command to create the CSR
    /// and a 2048 bit RSA private key.
    ///
    /// `openssl req -new -newkey rsa:2048 -days 365 -keyout
    /// private/test_cert_priv_key.pem -out csr/test_cert_.csr`
    ///
    /// If you have a configuration file, you can then use the following OpenSSL
    /// command. The `usr_cert` block in the configuration file contains your X509
    /// version 3 extensions.
    ///
    /// `openssl req -new -config openssl_rsa.cnf -extensions usr_cert -newkey
    /// rsa:2048 -days 365 -keyout private/test_cert_priv_key.pem -out
    /// csr/test_cert_.csr`
    ///
    /// Note: A CSR must provide either a *subject name* or a *subject alternative
    /// name* or the request will be rejected.
    csr: []const u8,

    /// Alphanumeric string that can be used to distinguish between calls to the
    /// **IssueCertificate** action. Idempotency tokens for **IssueCertificate**
    /// time out after five minutes. Therefore, if you call **IssueCertificate**
    /// multiple times with the same idempotency token within five minutes, Amazon
    /// Web Services Private CA recognizes that you are requesting only one
    /// certificate and will issue only one. If you change the idempotency token for
    /// each call, Amazon Web Services Private CA recognizes that you are requesting
    /// multiple certificates.
    idempotency_token: ?[]const u8 = null,

    /// The name of the algorithm that will be used to sign the certificate to be
    /// issued.
    ///
    /// This parameter should not be confused with the `SigningAlgorithm` parameter
    /// used to sign a CSR in the `CreateCertificateAuthority` action.
    ///
    /// The specified signing algorithm family (RSA or ECDSA) must match the
    /// algorithm family of the CA's secret key.
    signing_algorithm: SigningAlgorithm,

    /// Specifies a custom configuration template to use when issuing a certificate.
    /// If this parameter is not provided, Amazon Web Services Private CA defaults
    /// to the `EndEntityCertificate/V1` template. For CA certificates, you should
    /// choose the shortest path length that meets your needs. The path length is
    /// indicated by the PathLen*N* portion of the ARN, where *N* is the [CA
    /// depth](https://docs.aws.amazon.com/privateca/latest/userguide/PcaTerms.html#terms-cadepth).
    ///
    /// Note: The CA depth configured on a subordinate CA certificate must not
    /// exceed the limit set by its parents in the CA hierarchy.
    ///
    /// For a list of `TemplateArn` values supported by Amazon Web Services Private
    /// CA, see [Understanding Certificate
    /// Templates](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html).
    template_arn: ?[]const u8 = null,

    /// Information describing the end of the validity period of the certificate.
    /// This parameter sets the “Not After” date for the certificate.
    ///
    /// Certificate validity is the period of time during which a certificate is
    /// valid. Validity can be expressed as an explicit date and time when the
    /// certificate expires, or as a span of time after issuance, stated in days,
    /// months, or years. For more information, see
    /// [Validity](https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.5) in
    /// RFC 5280.
    ///
    /// This value is unaffected when `ValidityNotBefore` is also specified. For
    /// example, if `Validity` is set to 20 days in the future, the certificate will
    /// expire 20 days from issuance time regardless of the `ValidityNotBefore`
    /// value.
    ///
    /// The end of the validity period configured on a certificate must not exceed
    /// the limit set on its parents in the CA hierarchy.
    validity: Validity,

    /// Information describing the start of the validity period of the certificate.
    /// This parameter sets the “Not Before" date for the certificate.
    ///
    /// By default, when issuing a certificate, Amazon Web Services Private CA sets
    /// the "Not Before" date to the issuance time minus 60 minutes. This
    /// compensates for clock inconsistencies across computer systems. The
    /// `ValidityNotBefore` parameter can be used to customize the “Not Before”
    /// value.
    ///
    /// Unlike the `Validity` parameter, the `ValidityNotBefore` parameter is
    /// optional.
    ///
    /// The `ValidityNotBefore` value is expressed as an explicit date and time,
    /// using the `Validity` type value `ABSOLUTE`. For more information, see
    /// [Validity](https://docs.aws.amazon.com/privateca/latest/APIReference/API_Validity.html) in this API reference and [Validity](https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.5) in RFC 5280.
    validity_not_before: ?Validity = null,

    pub const json_field_names = .{
        .api_passthrough = "ApiPassthrough",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .csr = "Csr",
        .idempotency_token = "IdempotencyToken",
        .signing_algorithm = "SigningAlgorithm",
        .template_arn = "TemplateArn",
        .validity = "Validity",
        .validity_not_before = "ValidityNotBefore",
    };
};

pub const IssueCertificateOutput = struct {
    /// The Amazon Resource Name (ARN) of the issued certificate and the certificate
    /// serial number. This is of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012*/certificate/*286535153982981100925020015808220737245* `
    certificate_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IssueCertificateInput, options: CallOptions) !IssueCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm-pca", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: IssueCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm-pca", "ACM PCA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.IssueCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IssueCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(IssueCertificateOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "CertificateMismatchException")) {
        const parsed_error: ?errors.CertificateMismatchException = aws.json.parseJsonObject(errors.CertificateMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .certificate_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArgsException")) {
        const parsed_error: ?errors.InvalidArgsException = aws.json.parseJsonObject(errors.InvalidArgsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_args_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        const parsed_error: ?errors.InvalidArnException = aws.json.parseJsonObject(errors.InvalidArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        const parsed_error: ?errors.InvalidPolicyException = aws.json.parseJsonObject(errors.InvalidPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        const parsed_error: ?errors.InvalidStateException = aws.json.parseJsonObject(errors.InvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?errors.InvalidTagException = aws.json.parseJsonObject(errors.InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LockoutPreventedException")) {
        const parsed_error: ?errors.LockoutPreventedException = aws.json.parseJsonObject(errors.LockoutPreventedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lockout_prevented_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedCertificateException")) {
        const parsed_error: ?errors.MalformedCertificateException = aws.json.parseJsonObject(errors.MalformedCertificateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_certificate_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedCSRException")) {
        const parsed_error: ?errors.MalformedCSRException = aws.json.parseJsonObject(errors.MalformedCSRException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_csr_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PermissionAlreadyExistsException")) {
        const parsed_error: ?errors.PermissionAlreadyExistsException = aws.json.parseJsonObject(errors.PermissionAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .permission_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestAlreadyProcessedException")) {
        const parsed_error: ?errors.RequestAlreadyProcessedException = aws.json.parseJsonObject(errors.RequestAlreadyProcessedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_already_processed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestFailedException")) {
        const parsed_error: ?errors.RequestFailedException = aws.json.parseJsonObject(errors.RequestFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestInProgressException")) {
        const parsed_error: ?errors.RequestInProgressException = aws.json.parseJsonObject(errors.RequestInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
