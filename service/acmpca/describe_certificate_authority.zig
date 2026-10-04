const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateAuthority = @import("certificate_authority.zig").CertificateAuthority;

pub const DescribeCertificateAuthorityInput = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html). This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `.
    certificate_authority_arn: []const u8,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
    };
};

pub const DescribeCertificateAuthorityOutput = struct {
    /// A
    /// [CertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CertificateAuthority.html) structure that contains information about your private CA.
    certificate_authority: ?CertificateAuthority = null,

    pub const json_field_names = .{
        .certificate_authority = "CertificateAuthority",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCertificateAuthorityInput, options: CallOptions) !DescribeCertificateAuthorityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCertificateAuthorityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.DescribeCertificateAuthority");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCertificateAuthorityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCertificateAuthorityOutput, body, allocator);
}
