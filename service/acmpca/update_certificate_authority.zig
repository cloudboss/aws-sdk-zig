const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevocationConfiguration = @import("revocation_configuration.zig").RevocationConfiguration;
const CertificateAuthorityStatus = @import("certificate_authority_status.zig").CertificateAuthorityStatus;

pub const UpdateCertificateAuthorityInput = struct {
    /// Amazon Resource Name (ARN) of the private CA that issued the certificate to
    /// be revoked. This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `
    certificate_authority_arn: []const u8,

    /// Contains information to enable support for Online Certificate Status
    /// Protocol (OCSP), certificate revocation list (CRL), both protocols, or
    /// neither. If you don't supply this parameter, existing capibilites remain
    /// unchanged. For more information, see the
    /// [OcspConfiguration](https://docs.aws.amazon.com/privateca/latest/APIReference/API_OcspConfiguration.html) and [CrlConfiguration](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CrlConfiguration.html) types.
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
    /// If you update the `S3BucketName` of
    /// [CrlConfiguration](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CrlConfiguration.html), you can break revocation for existing certificates. In other words, if you call [UpdateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UpdateCertificateAuthority.html) to update the CRL configuration's S3 bucket name, Amazon Web Services Private CA only writes CRLs to the new S3 bucket. Certificates issued prior to this point will have the old S3 bucket name in your CRL Distribution Point (CDP) extension, essentially breaking revocation. If you must update the S3 bucket, you'll need to reissue old certificates to keep the revocation working. Alternatively, you can use a [CustomCname](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CrlConfiguration.html#privateca-Type-CrlConfiguration-CustomCname) in your CRL configuration if you might need to change the S3 bucket name in the future.
    revocation_configuration: ?RevocationConfiguration = null,

    /// Status of your private CA.
    status: ?CertificateAuthorityStatus = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .revocation_configuration = "RevocationConfiguration",
        .status = "Status",
    };
};

pub const UpdateCertificateAuthorityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCertificateAuthorityInput, options: CallOptions) !UpdateCertificateAuthorityOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCertificateAuthorityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.UpdateCertificateAuthority");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCertificateAuthorityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
