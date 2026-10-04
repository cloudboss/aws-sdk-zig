const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevocationReason = @import("revocation_reason.zig").RevocationReason;

pub const RevokeCertificateInput = struct {
    /// Amazon Resource Name (ARN) of the private CA that issued the certificate to
    /// be revoked. This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `
    certificate_authority_arn: []const u8,

    /// Serial number of the certificate to be revoked. This must be in hexadecimal
    /// format. You can retrieve the serial number by calling
    /// [GetCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetCertificate.html) with the Amazon Resource Name (ARN) of the certificate you want and the ARN of your private CA. The **GetCertificate** action retrieves the certificate in the PEM format. You can use the following OpenSSL command to list the certificate in text format and copy the hexadecimal serial number.
    ///
    /// `openssl x509 -in *file_path* -text -noout`
    ///
    /// You can also copy the serial number from the console or use the
    /// [DescribeCertificate](https://docs.aws.amazon.com/acm/latest/APIReference/API_DescribeCertificate.html) action in the *Certificate Manager API Reference*.
    certificate_serial: []const u8,

    /// Specifies why you revoked the certificate.
    revocation_reason: RevocationReason,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .certificate_serial = "CertificateSerial",
        .revocation_reason = "RevocationReason",
    };
};

pub const RevokeCertificateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeCertificateInput, options: CallOptions) !RevokeCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.RevokeCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeCertificateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
