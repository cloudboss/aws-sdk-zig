const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyMaterialType = @import("key_material_type.zig").KeyMaterialType;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;

pub const GetParametersForExportInput = struct {
    /// The key block format type (for example, TR-34 or TR-31) to use during key
    /// material export. Export token is only required for a TR-34 key export,
    /// `TR34_KEY_BLOCK`. Export token is not required for TR-31 key export.
    key_material_type: KeyMaterialType,

    /// Specifies whether to reuse the existing export token and signing key
    /// certificate. If set to `true` and a valid export token exists for the same
    /// key material type and signing key algorithm with at least 7 days of
    /// remaining validity, the existing token and signing key certificate are
    /// returned. Otherwise, a new export token and signing key certificate are
    /// generated. The default value is `false`, which generates a new export token
    /// and signing key certificate on every call.
    reuse_last_generated_token: ?bool = null,

    /// The signing key algorithm to generate a signing key certificate. This
    /// certificate signs the wrapped key under export within the TR-34 key block.
    /// `RSA_2048` is the only signing key algorithm allowed.
    signing_key_algorithm: KeyAlgorithm,

    pub const json_field_names = .{
        .key_material_type = "KeyMaterialType",
        .reuse_last_generated_token = "ReuseLastGeneratedToken",
        .signing_key_algorithm = "SigningKeyAlgorithm",
    };
};

pub const GetParametersForExportOutput = struct {
    /// The export token to initiate key export from Amazon Web Services Payment
    /// Cryptography. The export token expires after 30 days. You can use the same
    /// export token to export multiple keys from the same service account.
    export_token: []const u8,

    /// The validity period of the export token.
    parameters_valid_until_timestamp: i64,

    /// The algorithm of the signing key certificate for use in TR-34 key block
    /// generation. `RSA_2048` is the only signing key algorithm allowed.
    signing_key_algorithm: KeyAlgorithm,

    /// The signing key certificate in PEM format (base64 encoded) of the public key
    /// for signature within the TR-34 key block. The certificate expires after 30
    /// days.
    signing_key_certificate: []const u8,

    /// The root certificate authority (CA) that signed the signing key certificate
    /// in PEM format (base64 encoded).
    signing_key_certificate_chain: []const u8,

    pub const json_field_names = .{
        .export_token = "ExportToken",
        .parameters_valid_until_timestamp = "ParametersValidUntilTimestamp",
        .signing_key_algorithm = "SigningKeyAlgorithm",
        .signing_key_certificate = "SigningKeyCertificate",
        .signing_key_certificate_chain = "SigningKeyCertificateChain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParametersForExportInput, options: CallOptions) !GetParametersForExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetParametersForExportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.GetParametersForExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetParametersForExportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetParametersForExportOutput, body, allocator);
}
