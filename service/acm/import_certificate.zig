const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ImportCertificateInput = struct {
    /// The certificate to import.
    certificate: []const u8,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an imported certificate to replace. To import a new certificate, omit this field.
    certificate_arn: ?[]const u8 = null,

    /// The PEM encoded certificate chain.
    certificate_chain: ?[]const u8 = null,

    /// The private key that matches the public key in the certificate.
    private_key: []const u8,

    /// One or more resource tags to associate with the imported certificate.
    ///
    /// Note: You cannot apply tags when reimporting a certificate.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .certificate_arn = "CertificateArn",
        .certificate_chain = "CertificateChain",
        .private_key = "PrivateKey",
        .tags = "Tags",
    };
};

pub const ImportCertificateOutput = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the imported certificate.
    certificate_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCertificateInput, options: CallOptions) !ImportCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.ImportCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportCertificateOutput, body, allocator);
}
