const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ImportCertificateAuthorityCertificateInput = struct {
    /// The PEM-encoded certificate for a private CA. This may be a self-signed
    /// certificate in the case of a root CA, or it may be signed by another CA that
    /// you control.
    certificate: []const u8,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html). This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `
    certificate_authority_arn: []const u8,

    /// A PEM-encoded file that contains all of your certificates, other than the
    /// certificate you're importing, chaining up to your root CA. Your Amazon Web
    /// Services Private CA-hosted or on-premises root certificate is the last in
    /// the chain, and each certificate in the chain signs the one preceding.
    ///
    /// This parameter must be supplied when you import a subordinate CA. When you
    /// import a root CA, there is no chain.
    certificate_chain: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .certificate_chain = "CertificateChain",
    };
};

pub const ImportCertificateAuthorityCertificateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCertificateAuthorityCertificateInput, options: CallOptions) !ImportCertificateAuthorityCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportCertificateAuthorityCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.ImportCertificateAuthorityCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCertificateAuthorityCertificateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
