const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyMaterialType = @import("key_material_type.zig").KeyMaterialType;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;

pub const GetParametersForImportInput = struct {
    /// The method to use for key material import. Import token is only required for
    /// TR-34 WrappedKeyBlock (`TR34_KEY_BLOCK`) and RSA WrappedKeyCryptogram
    /// (`KEY_CRYPTOGRAM`).
    ///
    /// Import token is not required for TR-31, root public key cerificate or
    /// trusted public key certificate.
    key_material_type: KeyMaterialType,

    /// Specifies whether to reuse the existing import token and wrapping key
    /// certificate. If set to `true` and a valid import token exists for the same
    /// key material type and wrapping key algorithm with at least 7 days of
    /// remaining validity, the existing token and wrapping key certificate are
    /// returned. Otherwise, a new import token and wrapping key certificate are
    /// generated. The default value is `false`, which generates a new import token
    /// and wrapping key certificate on every call.
    reuse_last_generated_token: ?bool = null,

    /// The wrapping key algorithm to generate a wrapping key certificate. This
    /// certificate wraps the key under import.
    ///
    /// At this time, `RSA_2048` is the allowed algorithm for TR-34 WrappedKeyBlock
    /// import. Additionally, `RSA_2048`, `RSA_3072`, `RSA_4096` are the allowed
    /// algorithms for RSA WrappedKeyCryptogram import.
    wrapping_key_algorithm: KeyAlgorithm,

    pub const json_field_names = .{
        .key_material_type = "KeyMaterialType",
        .reuse_last_generated_token = "ReuseLastGeneratedToken",
        .wrapping_key_algorithm = "WrappingKeyAlgorithm",
    };
};

pub const GetParametersForImportOutput = struct {
    /// The import token to initiate key import into Amazon Web Services Payment
    /// Cryptography. The import token expires after 30 days. You can use the same
    /// import token to import multiple keys to the same service account.
    import_token: []const u8,

    /// The validity period of the import token.
    parameters_valid_until_timestamp: i64,

    /// The algorithm of the wrapping key for use within TR-34 WrappedKeyBlock or
    /// RSA WrappedKeyCryptogram.
    wrapping_key_algorithm: KeyAlgorithm,

    /// The wrapping key certificate in PEM format (base64 encoded) of the wrapping
    /// key for use within the TR-34 key block. The certificate expires in 30 days.
    wrapping_key_certificate: []const u8,

    /// The Amazon Web Services Payment Cryptography root certificate authority (CA)
    /// that signed the wrapping key certificate in PEM format (base64 encoded).
    wrapping_key_certificate_chain: []const u8,

    pub const json_field_names = .{
        .import_token = "ImportToken",
        .parameters_valid_until_timestamp = "ParametersValidUntilTimestamp",
        .wrapping_key_algorithm = "WrappingKeyAlgorithm",
        .wrapping_key_certificate = "WrappingKeyCertificate",
        .wrapping_key_certificate_chain = "WrappingKeyCertificateChain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParametersForImportInput, options: CallOptions) !GetParametersForImportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetParametersForImportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.GetParametersForImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetParametersForImportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetParametersForImportOutput, body, allocator);
}
