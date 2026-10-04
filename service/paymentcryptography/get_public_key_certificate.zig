const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPublicKeyCertificateInput = struct {
    /// The `KeyARN` of the asymmetric key pair.
    key_identifier: []const u8,

    pub const json_field_names = .{
        .key_identifier = "KeyIdentifier",
    };
};

pub const GetPublicKeyCertificateOutput = struct {
    /// The public key component of the asymmetric key pair in a certificate PEM
    /// format (base64 encoded). It is signed by the root certificate authority
    /// (CA). The certificate is valid for 90 days from the time it is issued. The
    /// service returns a cached certificate if one exists with at least 30 days of
    /// remaining validity. Otherwise, a new 90-day certificate is issued.
    key_certificate: []const u8,

    /// The root certificate authority (CA) that signed the public key certificate
    /// in PEM format (base64 encoded) of the asymmetric key pair.
    key_certificate_chain: []const u8,

    pub const json_field_names = .{
        .key_certificate = "KeyCertificate",
        .key_certificate_chain = "KeyCertificateChain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPublicKeyCertificateInput, options: CallOptions) !GetPublicKeyCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "payment-cryptography", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPublicKeyCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlplane.payment-cryptography", "Payment Cryptography", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.GetPublicKeyCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPublicKeyCertificateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPublicKeyCertificateOutput, body, allocator);
}
