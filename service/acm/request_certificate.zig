const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainValidationOption = @import("domain_validation_option.zig").DomainValidationOption;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;
const CertificateOptions = @import("certificate_options.zig").CertificateOptions;
const Tag = @import("tag.zig").Tag;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;

pub const RequestCertificateInput = struct {
    /// The Amazon Resource Name (ARN) of the private certificate authority (CA)
    /// that will be used to issue the certificate. If you do not provide an ARN and
    /// you are trying to request a private certificate, ACM will attempt to issue a
    /// public certificate. For more information about private CAs, see the [Amazon
    /// Web Services Private Certificate
    /// Authority](https://docs.aws.amazon.com/privateca/latest/userguide/PcaWelcome.html) user guide. The ARN must have the following form:
    ///
    /// `arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-1234-123456789012`
    certificate_authority_arn: ?[]const u8 = null,

    /// Fully qualified domain name (FQDN), such as www.example.com, that you want
    /// to secure with an ACM certificate. Use an asterisk (*) to create a wildcard
    /// certificate that protects several sites in the same domain. For example,
    /// *.example.com protects www.example.com, site.example.com, and
    /// images.example.com.
    ///
    /// In compliance with [RFC
    /// 5280](https://datatracker.ietf.org/doc/html/rfc5280), the length of the
    /// domain name (technically, the Common Name) that you provide cannot exceed 64
    /// octets (characters), including periods. To add a longer domain name, specify
    /// it in the Subject Alternative Name field, which supports names up to 253
    /// octets in length.
    domain_name: []const u8,

    /// The domain name that you want ACM to use to send you emails so that you can
    /// validate domain ownership.
    domain_validation_options: ?[]const DomainValidationOption = null,

    /// Customer chosen string that can be used to distinguish between calls to
    /// `RequestCertificate`. Idempotency tokens time out after one hour. Therefore,
    /// if you call `RequestCertificate` multiple times with the same idempotency
    /// token within one hour, ACM recognizes that you are requesting only one
    /// certificate and will issue only one. If you change the idempotency token for
    /// each call, ACM recognizes that you are requesting multiple certificates.
    idempotency_token: ?[]const u8 = null,

    /// Specifies the algorithm of the public and private key pair that your
    /// certificate uses to encrypt data. RSA is the default key algorithm for ACM
    /// certificates. Elliptic Curve Digital Signature Algorithm (ECDSA) keys are
    /// smaller, offering security comparable to RSA keys but with greater computing
    /// efficiency. However, ECDSA is not supported by all network clients. Some
    /// Amazon Web Services services may require RSA keys, or only support ECDSA
    /// keys of a particular size, while others allow the use of either RSA and
    /// ECDSA keys to ensure that compatibility is not broken. Check the
    /// requirements for the Amazon Web Services service where you plan to deploy
    /// your certificate. For more information about selecting an algorithm, see
    /// [Key
    /// algorithms](https://docs.aws.amazon.com/acm/latest/userguide/acm-certificate-characteristics.html#algorithms-term).
    ///
    /// Algorithms supported for an ACM certificate request include:
    ///
    /// * `RSA_2048`
    /// * `EC_prime256v1`
    /// * `EC_secp384r1`
    ///
    /// Other listed algorithms are for imported certificates only.
    ///
    /// When you request a private PKI certificate signed by a CA from Amazon Web
    /// Services Private CA, the specified signing algorithm family (RSA or ECDSA)
    /// must match the algorithm family of the CA's secret key.
    ///
    /// Default: RSA_2048
    key_algorithm: ?KeyAlgorithm = null,

    /// Identifies the Amazon Web Services service that manages the certificate
    /// issued by ACM.
    managed_by: ?CertificateManagedBy = null,

    /// You can use this parameter to specify whether to add the certificate to a
    /// certificate transparency log and export your certificate.
    ///
    /// Certificate transparency makes it possible to detect SSL/TLS certificates
    /// that have been mistakenly or maliciously issued. Certificates that have not
    /// been logged typically produce an error message in a browser. For more
    /// information, see [Opting Out of Certificate Transparency
    /// Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-bestpractices.html#best-practices-transparency).
    ///
    /// You can export public ACM certificates to use with Amazon Web Services
    /// services as well as outside the Amazon Web Services Cloud. For more
    /// information, see [Certificate Manager exportable public
    /// certificate](https://docs.aws.amazon.com/acm/latest/userguide/acm-exportable-certificates.html).
    options: ?CertificateOptions = null,

    /// Additional FQDNs to be included in the Subject Alternative Name extension of
    /// the ACM certificate. For example, add the name www.example.net to a
    /// certificate for which the `DomainName` field is www.example.com if users can
    /// reach your site by using either name. The maximum number of domain names
    /// that you can add to an ACM certificate is 100. However, the initial quota is
    /// 10 domain names. If you need more than 10 names, you must request a quota
    /// increase. For more information, see
    /// [Quotas](https://docs.aws.amazon.com/acm/latest/userguide/acm-limits.html).
    ///
    /// The maximum length of a SAN DNS name is 253 octets. The name is made up of
    /// multiple labels separated by periods. No label can be longer than 63 octets.
    /// Consider the following examples:
    ///
    /// * `(63 octets).(63 octets).(63 octets).(61 octets)` is legal because the
    ///   total length is 253 octets (63+1+63+1+63+1+61) and no label exceeds 63
    ///   octets.
    /// * `(64 octets).(63 octets).(63 octets).(61 octets)` is not legal because the
    ///   total length exceeds 253 octets (64+1+63+1+63+1+61) and the first label
    ///   exceeds 63 octets.
    /// * `(63 octets).(63 octets).(63 octets).(62 octets)` is not legal because the
    ///   total length of the DNS name (63+1+63+1+63+1+62) exceeds 253 octets.
    subject_alternative_names: ?[]const []const u8 = null,

    /// One or more resource tags to associate with the certificate.
    tags: ?[]const Tag = null,

    /// The method you want to use if you are requesting a public certificate to
    /// validate that you own or control domain. You can [validate with
    /// DNS](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-dns.html) or [validate with email](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-email.html). We recommend that you use DNS validation.
    validation_method: ?ValidationMethod = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .domain_name = "DomainName",
        .domain_validation_options = "DomainValidationOptions",
        .idempotency_token = "IdempotencyToken",
        .key_algorithm = "KeyAlgorithm",
        .managed_by = "ManagedBy",
        .options = "Options",
        .subject_alternative_names = "SubjectAlternativeNames",
        .tags = "Tags",
        .validation_method = "ValidationMethod",
    };
};

pub const RequestCertificateOutput = struct {
    /// String that contains the ARN of the issued certificate. This must be of the
    /// form:
    ///
    /// `arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012`
    certificate_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestCertificateInput, options: CallOptions) !RequestCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RequestCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm", "ACM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.RequestCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RequestCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RequestCertificateOutput, body, allocator);
}
