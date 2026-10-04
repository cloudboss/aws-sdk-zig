const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyAgreementAlgorithmSpec = @import("key_agreement_algorithm_spec.zig").KeyAgreementAlgorithmSpec;
const RecipientInfo = @import("recipient_info.zig").RecipientInfo;
const OriginType = @import("origin_type.zig").OriginType;

pub const DeriveSharedSecretInput = struct {
    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Specifies the key agreement algorithm used to derive the shared secret. The
    /// only valid
    /// value is `ECDH`.
    key_agreement_algorithm: KeyAgreementAlgorithmSpec,

    /// Identifies an asymmetric NIST-standard ECC or SM2 (China Regions only) KMS
    /// key. KMS
    /// uses the private key in the specified key pair to derive the shared secret.
    /// The key usage of
    /// the KMS key must be `KEY_AGREEMENT`. To find the `KeyUsage` of a KMS
    /// key, use the DescribeKey operation.
    ///
    /// To specify a KMS key, use its key ID, key ARN, alias name, or alias ARN.
    /// When using an alias name, prefix it with `"alias/"`. To specify a KMS key in
    /// a different Amazon Web Services account, you must use the key ARN or alias
    /// ARN.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Alias name: `alias/ExampleAlias`
    ///
    /// * Alias ARN: `arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey. To
    /// get the alias name and alias ARN, use ListAliases.
    key_id: []const u8,

    /// Specifies the public key in your peer's NIST-standard elliptic curve (ECC)
    /// or SM2
    /// (China Regions only) key pair.
    ///
    /// The public key must be a DER-encoded X.509 public key, also known as
    /// `SubjectPublicKeyInfo` (SPKI), as defined in [RFC
    /// 5280](https://tools.ietf.org/html/rfc5280).
    ///
    /// GetPublicKey returns the public key of an asymmetric KMS key pair in the
    /// required DER-encoded format.
    ///
    /// If you use [Amazon Web Services CLI version
    /// 1](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-welcome.html), you
    /// must provide the DER-encoded X.509 public key in a file.
    /// Otherwise, the Amazon Web Services CLI Base64-encodes the public key a
    /// second time, resulting in a
    /// `ValidationException`.
    ///
    /// You can specify the public key as binary data in a file using fileb
    /// (`fileb://`) or in-line using a Base64 encoded string.
    public_key: []const u8,

    /// A signed [attestation
    /// document](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitro-enclave-how.html#term-attestdoc) from
    /// an Amazon Web Services Nitro enclave or NitroTPM, and the encryption
    /// algorithm to use with the public key in
    /// the attestation document. The only valid encryption algorithm is
    /// `RSAES_OAEP_SHA_256`.
    ///
    /// This parameter only supports attestation documents for Amazon Web Services
    /// Nitro Enclaves or
    /// Amazon Web Services NitroTPM. To call DeriveSharedSecret generate an
    /// attestation document use either
    /// [Amazon Web Services Nitro Enclaves
    /// SDK](https://docs.aws.amazon.com/enclaves/latest/user/developing-applications.html#sdk) for an Amazon Web Services Nitro Enclaves or [Amazon Web Services NitroTPM tools](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/attestation-get-doc.html) for
    /// Amazon Web Services NitroTPM. Then use the Recipient parameter from any
    /// Amazon Web Services SDK to provide the
    /// attestation document for the attested environment.
    ///
    /// When you use this parameter, instead of returning a plaintext copy of the
    /// shared secret,
    /// KMS encrypts the plaintext shared secret under the public key in the
    /// attestation document,
    /// and returns the resulting ciphertext in the `CiphertextForRecipient` field
    /// in the
    /// response. This ciphertext can be decrypted only with the private key in the
    /// attested
    /// environment. The `CiphertextBlob` field in the response contains the
    /// encrypted
    /// shared secret derived from the KMS key specified by the `KeyId` parameter
    /// and
    /// public key specified by the `PublicKey` parameter. The `SharedSecret`
    /// field in the response is null or empty.
    ///
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    recipient: ?RecipientInfo = null,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .grant_tokens = "GrantTokens",
        .key_agreement_algorithm = "KeyAgreementAlgorithm",
        .key_id = "KeyId",
        .public_key = "PublicKey",
        .recipient = "Recipient",
    };
};

pub const DeriveSharedSecretOutput = struct {
    /// The plaintext shared secret encrypted with the public key from the
    /// attestation document.
    /// This ciphertext can be decrypted only by using a private key from the
    /// attested environment.
    ///
    /// This field is included in the response only when the `Recipient` parameter
    /// in
    /// the request includes a valid attestation document from an Amazon Web
    /// Services Nitro enclave or NitroTPM.
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    ciphertext_for_recipient: ?[]const u8 = null,

    /// Identifies the key agreement algorithm used to derive the shared secret.
    key_agreement_algorithm: ?KeyAgreementAlgorithmSpec = null,

    /// Identifies the KMS key used to derive the shared secret.
    key_id: ?[]const u8 = null,

    /// The source of the key material for the specified KMS key.
    ///
    /// When this value is `AWS_KMS`, KMS created the key material. When this value
    /// is `EXTERNAL`, the key material was imported or the KMS key doesn't have any
    /// key
    /// material.
    ///
    /// The only valid values for DeriveSharedSecret are `AWS_KMS` and
    /// `EXTERNAL`. DeriveSharedSecret does not support KMS keys with a
    /// `KeyOrigin` value of `AWS_CLOUDHSM` or
    /// `EXTERNAL_KEY_STORE`.
    key_origin: ?OriginType = null,

    /// The raw secret derived from the specified key agreement algorithm, private
    /// key in the
    /// asymmetric KMS key, and your peer's public key.
    ///
    /// If the response includes the `CiphertextForRecipient` field, the
    /// `SharedSecret` field is null or empty.
    shared_secret: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_for_recipient = "CiphertextForRecipient",
        .key_agreement_algorithm = "KeyAgreementAlgorithm",
        .key_id = "KeyId",
        .key_origin = "KeyOrigin",
        .shared_secret = "SharedSecret",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeriveSharedSecretInput, options: CallOptions) !DeriveSharedSecretOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeriveSharedSecretInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.DeriveSharedSecret");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeriveSharedSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeriveSharedSecretOutput, body, allocator);
}
