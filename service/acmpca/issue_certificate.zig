const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "acm-pca");

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

fn serializeRequest(allocator: std.mem.Allocator, input: IssueCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm-pca", "ACM PCA", allocator);

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

    if (std.mem.eql(u8, error_code, "CertificateMismatchException")) {
        return .{ .arena = arena, .kind = .{ .certificate_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidArgsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_args_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
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
    if (std.mem.eql(u8, error_code, "LockoutPreventedException")) {
        return .{ .arena = arena, .kind = .{ .lockout_prevented_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedCertificateException")) {
        return .{ .arena = arena, .kind = .{ .malformed_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedCSRException")) {
        return .{ .arena = arena, .kind = .{ .malformed_csr_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .permission_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestAlreadyProcessedException")) {
        return .{ .arena = arena, .kind = .{ .request_already_processed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .request_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestInProgressException")) {
        return .{ .arena = arena, .kind = .{ .request_in_progress_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
