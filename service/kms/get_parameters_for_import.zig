const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlgorithmSpec = @import("algorithm_spec.zig").AlgorithmSpec;
const WrappingKeySpec = @import("wrapping_key_spec.zig").WrappingKeySpec;

pub const GetParametersForImportInput = struct {
    /// The identifier of the KMS key that will be associated with the imported key
    /// material. The
    /// `Origin` of the KMS key must be `EXTERNAL`.
    ///
    /// All KMS key types are supported, including multi-Region keys. However, you
    /// cannot import
    /// key material into a KMS key in a custom key store.
    ///
    /// Specify the key ID or key ARN of the KMS key.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// The algorithm you will use with the RSA public key (`PublicKey`) in the
    /// response to protect your key material during import. For more information,
    /// see [Select a wrapping
    /// algorithm](https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-get-public-key-and-token.html#select-wrapping-algorithm) in the *Key Management Service Developer Guide*.
    ///
    /// For RSA_AES wrapping algorithms, you encrypt your key material with an AES
    /// key that you
    /// generate, then encrypt your AES key with the RSA public key from KMS. For
    /// RSAES wrapping
    /// algorithms, you encrypt your key material directly with the RSA public key
    /// from KMS.
    ///
    /// The wrapping algorithms that you can use depend on the type of key material
    /// that you are
    /// importing. To import an RSA private key, you must use an RSA_AES wrapping
    /// algorithm.
    ///
    /// * **RSA_AES_KEY_WRAP_SHA_256** — Supported for
    /// wrapping RSA and ECC key material.
    ///
    /// * **RSA_AES_KEY_WRAP_SHA_1** — Supported for
    /// wrapping RSA and ECC key material.
    ///
    /// * **RSAES_OAEP_SHA_256** — Supported for all types
    /// of key material, except RSA key material (private key).
    ///
    /// You cannot use the RSAES_OAEP_SHA_256 wrapping algorithm with the RSA_2048
    /// wrapping
    /// key spec to wrap ECC_NIST_P521 key material.
    ///
    /// * **RSAES_OAEP_SHA_1** — Supported for all types of
    /// key material, except RSA key material (private key).
    ///
    /// You cannot use the RSAES_OAEP_SHA_1 wrapping algorithm with the RSA_2048
    /// wrapping key
    /// spec to wrap ECC_NIST_P521 key material.
    ///
    /// * **RSAES_PKCS1_V1_5** (Deprecated) — As of October
    /// 10, 2023, KMS does not support the RSAES_PKCS1_V1_5 wrapping algorithm.
    wrapping_algorithm: AlgorithmSpec,

    /// The type of RSA public key to return in the response. You will use this
    /// wrapping key with
    /// the specified wrapping algorithm to protect your key material during import.
    ///
    /// Use the longest RSA wrapping key that is practical.
    ///
    /// You cannot use an RSA_2048 public key to directly wrap an ECC_NIST_P521
    /// private key.
    /// Instead, use an RSA_AES wrapping algorithm or choose a longer RSA public
    /// key.
    wrapping_key_spec: WrappingKeySpec,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .wrapping_algorithm = "WrappingAlgorithm",
        .wrapping_key_spec = "WrappingKeySpec",
    };
};

pub const GetParametersForImportOutput = struct {
    /// The import token to send in a subsequent ImportKeyMaterial
    /// request.
    import_token: ?[]const u8 = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key to use in a subsequent ImportKeyMaterial request. This is the same KMS key specified in the `GetParametersForImport`
    /// request.
    key_id: ?[]const u8 = null,

    /// The time at which the import token and public key are no longer valid. After
    /// this time,
    /// you cannot use them to make an ImportKeyMaterial request and you must send
    /// another `GetParametersForImport` request to get new ones.
    parameters_valid_to: ?i64 = null,

    /// The public key to use to encrypt the key material before importing it with
    /// ImportKeyMaterial.
    public_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .import_token = "ImportToken",
        .key_id = "KeyId",
        .parameters_valid_to = "ParametersValidTo",
        .public_key = "PublicKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParametersForImportInput, options: CallOptions) !GetParametersForImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GetParametersForImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetParametersForImportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetParametersForImportOutput, body, allocator);
}
