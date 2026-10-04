const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExportCertificateInput = struct {
    /// An Amazon Resource Name (ARN) of the issued certificate. This must be of the
    /// form:
    ///
    /// `arn:aws:acm:region:account:certificate/12345678-1234-1234-1234-123456789012`
    certificate_arn: []const u8,

    /// Passphrase to associate with the encrypted exported private key.
    ///
    /// When creating your passphrase, you can use any ASCII character except #, $,
    /// or %.
    ///
    /// If you want to later decrypt the private key, you must have the passphrase.
    /// You can use the following OpenSSL command to decrypt a private key. After
    /// entering the command, you are prompted for the passphrase.
    ///
    /// `openssl rsa -in encrypted_key.pem -out decrypted_key.pem`
    passphrase: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .passphrase = "Passphrase",
    };
};

pub const ExportCertificateOutput = struct {
    /// The base64 PEM-encoded certificate.
    certificate: ?[]const u8 = null,

    /// The base64 PEM-encoded certificate chain. This does not include the
    /// certificate that you are exporting.
    certificate_chain: ?[]const u8 = null,

    /// The encrypted private key associated with the public key in the certificate.
    /// The key is output in PKCS #8 format and is base64 PEM-encoded.
    private_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .certificate_chain = "CertificateChain",
        .private_key = "PrivateKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportCertificateInput, options: CallOptions) !ExportCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.ExportCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportCertificateOutput, body, allocator);
}
