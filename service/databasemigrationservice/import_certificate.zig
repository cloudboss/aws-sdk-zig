const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Certificate = @import("certificate.zig").Certificate;

pub const ImportCertificateInput = struct {
    /// A customer-assigned name for the certificate. Identifiers must begin with a
    /// letter and
    /// must contain only ASCII letters, digits, and hyphens. They can't end with a
    /// hyphen or
    /// contain two consecutive hyphens.
    certificate_identifier: []const u8,

    /// The contents of a `.pem` file, which contains an X.509 certificate.
    certificate_pem: ?[]const u8 = null,

    /// The location of an imported Oracle Wallet certificate for use with SSL.
    /// Provide the name
    /// of a `.sso` file using the `fileb://` prefix. You can't provide the
    /// certificate inline.
    ///
    /// Example: `filebase64("${path.root}/rds-ca-2019-root.sso")`
    certificate_wallet: ?[]const u8 = null,

    /// An KMS key identifier that is used to encrypt the certificate.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// The tags associated with the certificate.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .certificate_identifier = "CertificateIdentifier",
        .certificate_pem = "CertificatePem",
        .certificate_wallet = "CertificateWallet",
        .kms_key_id = "KmsKeyId",
        .tags = "Tags",
    };
};

pub const ImportCertificateOutput = struct {
    /// The certificate to be uploaded.
    certificate: ?Certificate = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCertificateInput, options: CallOptions) !ImportCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ImportCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportCertificateOutput, body, allocator);
}
