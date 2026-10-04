const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const ImportKeyMaterial = @import("import_key_material.zig").ImportKeyMaterial;
const Tag = @import("tag.zig").Tag;
const Key = @import("key.zig").Key;

pub const ImportKeyInput = struct {
    /// Specifies whether import key is enabled.
    enabled: ?bool = null,

    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result. For HMAC keys, the KCV is
    /// computed using the hash selected at key creation on a zero-length message,
    /// taking the leftmost 3 bytes.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    /// The key or public key certificate type to use during key material import,
    /// for example TR-34 or RootCertificatePublicKey.
    key_material: ImportKeyMaterial,

    replication_regions: ?[]const []const u8 = null,

    /// The comment from the requester explaining the reason for the import.
    ///
    /// Don't include personal, confidential or sensitive information in this field.
    /// This field may be displayed in plaintext in CloudTrail logs and other
    /// output.
    requester_comment: ?[]const u8 = null,

    /// Assigns one or more tags to the Amazon Web Services Payment Cryptography
    /// key. Use this parameter to tag a key when it is imported. To tag an existing
    /// Amazon Web Services Payment Cryptography key, use the
    /// [TagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_TagResource.html) operation.
    ///
    /// Each tag consists of a tag key and a tag value. Both the tag key and the tag
    /// value are required, but the tag value can be an empty (null) string. You
    /// can't have more than one tag on an Amazon Web Services Payment Cryptography
    /// key with the same tag key. If you specify an existing tag key with a
    /// different tag value, Amazon Web Services Payment Cryptography replaces the
    /// current tag value with the specified one.
    ///
    /// Don't include personal, confidential or sensitive information in this field.
    /// This field may be displayed in plaintext in CloudTrail logs and other
    /// output.
    ///
    /// Tagging or untagging an Amazon Web Services Payment Cryptography key can
    /// allow or deny permission to the key.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .key_material = "KeyMaterial",
        .replication_regions = "ReplicationRegions",
        .requester_comment = "RequesterComment",
        .tags = "Tags",
    };
};

pub const ImportKeyOutput = struct {
    /// The `KeyARN` of the key material imported within Amazon Web Services Payment
    /// Cryptography.
    key: ?Key = null,

    pub const json_field_names = .{
        .key = "Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportKeyInput, options: CallOptions) !ImportKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.ImportKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportKeyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportKeyOutput, body, allocator);
}
