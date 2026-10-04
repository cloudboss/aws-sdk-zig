const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecipientInfo = @import("recipient_info.zig").RecipientInfo;

pub const GenerateRandomInput = struct {
    /// Generates the random byte string in the CloudHSM cluster that is associated
    /// with the
    /// specified CloudHSM key store. To find the ID of a custom key store, use the
    /// DescribeCustomKeyStores operation.
    ///
    /// External key store IDs are not valid for this parameter. If you specify the
    /// ID of an
    /// external key store, `GenerateRandom` throws an
    /// `UnsupportedOperationException`.
    custom_key_store_id: ?[]const u8 = null,

    /// The length of the random byte string. This parameter is required.
    number_of_bytes: ?i32 = null,

    /// A signed [attestation
    /// document](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitro-enclave-how.html#term-attestdoc) from
    /// an Amazon Web Services Nitro enclave or NitroTPM, and the encryption
    /// algorithm to use with the public key in
    /// the attestation document. The only valid encryption algorithm is
    /// `RSAES_OAEP_SHA_256`.
    ///
    /// This parameter supports the [Amazon Web Services Nitro Enclaves
    /// SDK](https://docs.aws.amazon.com/enclaves/latest/user/developing-applications.html#sdk) or any Amazon Web Services SDK for
    /// Amazon Web Services Nitro Enclaves. It supports any Amazon Web Services SDK
    /// for Amazon Web Services NitroTPM.
    ///
    /// When you use this parameter, instead of returning plaintext bytes, KMS
    /// encrypts the
    /// plaintext bytes under the public key in the attestation document, and
    /// returns the resulting
    /// ciphertext in the `CiphertextForRecipient` field in the response. This
    /// ciphertext
    /// can be decrypted only with the private key in the attested environment. The
    /// `Plaintext` field in the response is null or empty.
    ///
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    recipient: ?RecipientInfo = null,

    pub const json_field_names = .{
        .custom_key_store_id = "CustomKeyStoreId",
        .number_of_bytes = "NumberOfBytes",
        .recipient = "Recipient",
    };
};

pub const GenerateRandomOutput = struct {
    /// The plaintext random bytes encrypted with the public key from the
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

    /// The random byte string. When you use the HTTP API or the Amazon Web Services
    /// CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.
    ///
    /// If the response includes the `CiphertextForRecipient` field, the
    /// `Plaintext` field is null or empty.
    plaintext: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_for_recipient = "CiphertextForRecipient",
        .plaintext = "Plaintext",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateRandomInput, options: CallOptions) !GenerateRandomOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateRandomInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GenerateRandom");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateRandomOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateRandomOutput, body, allocator);
}
