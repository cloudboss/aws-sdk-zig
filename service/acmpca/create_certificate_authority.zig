const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CertificateAuthorityConfiguration = @import("certificate_authority_configuration.zig").CertificateAuthorityConfiguration;
const CertificateAuthorityType = @import("certificate_authority_type.zig").CertificateAuthorityType;
const KeyStorageSecurityStandard = @import("key_storage_security_standard.zig").KeyStorageSecurityStandard;
const RevocationConfiguration = @import("revocation_configuration.zig").RevocationConfiguration;
const Tag = @import("tag.zig").Tag;
const CertificateAuthorityUsageMode = @import("certificate_authority_usage_mode.zig").CertificateAuthorityUsageMode;

pub const CreateCertificateAuthorityInput = struct {
    /// Name and bit size of the private key algorithm, the name of the signing
    /// algorithm, and X.500 certificate subject information.
    certificate_authority_configuration: CertificateAuthorityConfiguration,

    /// The type of the certificate authority.
    certificate_authority_type: CertificateAuthorityType,

    /// Custom string that can be used to distinguish between calls to the
    /// **CreateCertificateAuthority** action. Idempotency tokens for
    /// **CreateCertificateAuthority** time out after five minutes. Therefore, if
    /// you call **CreateCertificateAuthority** multiple times with the same
    /// idempotency token within five minutes, Amazon Web Services Private CA
    /// recognizes that you are requesting only certificate authority and will issue
    /// only one. If you change the idempotency token for each call, Amazon Web
    /// Services Private CA recognizes that you are requesting multiple certificate
    /// authorities.
    idempotency_token: ?[]const u8 = null,

    /// Specifies a cryptographic key management compliance standard for handling
    /// and protecting CA keys.
    ///
    /// Default: FIPS_140_2_LEVEL_3_OR_HIGHER
    ///
    /// Some Amazon Web Services Regions don't support the default value. When you
    /// create a CA in these Regions, you must use `CCPC_LEVEL_1_OR_HIGHER` for the
    /// `KeyStorageSecurityStandard` parameter. If you don't, the operation returns
    /// an `InvalidArgsException` with this message: "A certificate authority cannot
    /// be created in this region with the specified security standard."
    ///
    /// For information about security standard support in different Amazon Web
    /// Services Regions, see [Storage and security compliance of Amazon Web
    /// Services Private CA private
    /// keys](https://docs.aws.amazon.com/privateca/latest/userguide/data-protection.html#private-keys).
    key_storage_security_standard: ?KeyStorageSecurityStandard = null,

    /// Contains information to enable support for Online Certificate Status
    /// Protocol (OCSP), certificate revocation list (CRL), both protocols, or
    /// neither. By default, both certificate validation mechanisms are disabled.
    ///
    /// The following requirements apply to revocation configurations.
    ///
    /// * A configuration disabling CRLs or OCSP must contain only the
    ///   `Enabled=False` parameter, and will fail if other parameters such as
    ///   `CustomCname` or `ExpirationInDays` are included.
    /// * In a CRL configuration, the `S3BucketName` parameter must conform to
    ///   [Amazon S3 bucket naming
    ///   rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).
    /// * A configuration containing a custom Canonical Name (CNAME) parameter for
    ///   CRLs or OCSP must conform to
    ///   [RFC2396](https://www.ietf.org/rfc/rfc2396.txt) restrictions on the use of
    ///   special characters in a CNAME.
    /// * In a CRL or OCSP configuration, the value of a CNAME parameter must not
    ///   include a protocol prefix such as "http://" or "https://".
    ///
    /// For more information, see the
    /// [OcspConfiguration](https://docs.aws.amazon.com/privateca/latest/APIReference/API_OcspConfiguration.html) and [CrlConfiguration](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CrlConfiguration.html) types.
    revocation_configuration: ?RevocationConfiguration = null,

    /// Key-value pairs that will be attached to the new private CA. You can
    /// associate up to 50 tags with a private CA. For information using tags with
    /// IAM to manage permissions, see [Controlling Access Using IAM
    /// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_iam-tags.html).
    tags: ?[]const Tag = null,

    /// Specifies whether the CA issues general-purpose certificates that typically
    /// require a revocation mechanism, or short-lived certificates that may
    /// optionally omit revocation because they expire quickly. Short-lived
    /// certificate validity is limited to seven days.
    ///
    /// The default value is GENERAL_PURPOSE.
    usage_mode: ?CertificateAuthorityUsageMode = null,

    pub const json_field_names = .{
        .certificate_authority_configuration = "CertificateAuthorityConfiguration",
        .certificate_authority_type = "CertificateAuthorityType",
        .idempotency_token = "IdempotencyToken",
        .key_storage_security_standard = "KeyStorageSecurityStandard",
        .revocation_configuration = "RevocationConfiguration",
        .tags = "Tags",
        .usage_mode = "UsageMode",
    };
};

pub const CreateCertificateAuthorityOutput = struct {
    /// If successful, the Amazon Resource Name (ARN) of the certificate authority
    /// (CA). This is of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `.
    certificate_authority_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCertificateAuthorityInput, options: Options) !CreateCertificateAuthorityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "acmpca");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCertificateAuthorityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acmpca", "ACM PCA", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.CreateCertificateAuthority");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCertificateAuthorityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCertificateAuthorityOutput, body, allocator);
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
