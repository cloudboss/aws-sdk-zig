const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CertificateUsageType = @import("certificate_usage_type.zig").CertificateUsageType;

pub const ImportCertificateInput = struct {
    /// An optional date that specifies when the certificate becomes active. If you
    /// do not specify a value, `ActiveDate` takes the same value as
    /// `NotBeforeDate`, which is specified by the CA.
    active_date: ?i64 = null,

    /// * For the CLI, provide a file path for a certificate in URI format. For
    ///   example, `--certificate file://encryption-cert.pem`. Alternatively, you
    ///   can provide the raw content.
    /// * For the SDK, specify the raw content of a certificate file. For example,
    ///   `--certificate "`cat encryption-cert.pem`"`.
    ///
    /// You can provide both the certificate and its chain in this parameter,
    /// without needing to use the `CertificateChain` parameter. If you use this
    /// parameter for both the certificate and its chain, do not use the
    /// `CertificateChain` parameter.
    certificate: []const u8,

    /// An optional list of certificates that make up the chain for the certificate
    /// that's being imported.
    certificate_chain: ?[]const u8 = null,

    /// A short description that helps identify the certificate.
    description: ?[]const u8 = null,

    /// An optional date that specifies when the certificate becomes inactive. If
    /// you do not specify a value, `InactiveDate` takes the same value as
    /// `NotAfterDate`, which is specified by the CA.
    inactive_date: ?i64 = null,

    /// * For the CLI, provide a file path for a private key in URI format. For
    ///   example, `--private-key file://encryption-key.pem`. Alternatively, you can
    ///   provide the raw content of the private key file.
    /// * For the SDK, specify the raw content of a private key file. For example,
    ///   `--private-key "`cat encryption-key.pem`"`
    private_key: ?[]const u8 = null,

    /// Key-value pairs that can be used to group and search for certificates.
    tags: ?[]const Tag = null,

    /// Specifies how this certificate is used. It can be used in the following
    /// ways:
    ///
    /// * `SIGNING`: For signing AS2 messages
    /// * `ENCRYPTION`: For encrypting AS2 messages
    /// * `TLS`: For securing AS2 communications sent over HTTPS
    usage: CertificateUsageType,

    pub const json_field_names = .{
        .active_date = "ActiveDate",
        .certificate = "Certificate",
        .certificate_chain = "CertificateChain",
        .description = "Description",
        .inactive_date = "InactiveDate",
        .private_key = "PrivateKey",
        .tags = "Tags",
        .usage = "Usage",
    };
};

pub const ImportCertificateOutput = struct {
    /// An array of identifiers for the imported certificates. You use this
    /// identifier for working with profiles and partner profiles.
    certificate_id: []const u8,

    pub const json_field_names = .{
        .certificate_id = "CertificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCertificateInput, options: CallOptions) !ImportCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ImportCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCertificateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportCertificateOutput, body, allocator);
}
