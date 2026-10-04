const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeriveKeyUsage = @import("derive_key_usage.zig").DeriveKeyUsage;
const KeyAttributes = @import("key_attributes.zig").KeyAttributes;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const Tag = @import("tag.zig").Tag;
const Key = @import("key.zig").Key;

pub const CreateKeyInput = struct {
    /// The intended cryptographic usage of keys derived from the ECC key pair to be
    /// created.
    ///
    /// After creating an ECC key pair, you cannot change the intended cryptographic
    /// usage of keys derived from it using ECDH.
    derive_key_usage: ?DeriveKeyUsage = null,

    /// Specifies whether to enable the key. If the key is enabled, it is activated
    /// for use within the service. If the key is not enabled, then it is created
    /// but not activated. The default value is enabled.
    enabled: ?bool = null,

    /// Specifies whether the key is exportable from the service.
    exportable: bool,

    /// The role of the key, the algorithm it supports, and the cryptographic
    /// operations allowed with the key. This data is immutable after the key is
    /// created.
    key_attributes: KeyAttributes,

    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    replication_regions: ?[]const []const u8 = null,

    /// Assigns one or more tags to the Amazon Web Services Payment Cryptography
    /// key. Use this parameter to tag a key when it is created. To tag an existing
    /// Amazon Web Services Payment Cryptography key, use the
    /// [TagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_TagResource.html) operation.
    ///
    /// Each tag consists of a tag key and a tag value. Both the tag key and the tag
    /// value are required, but the tag value can be an empty (null) string. You
    /// can't have more than one tag on an Amazon Web Services Payment Cryptography
    /// key with the same tag key.
    ///
    /// Don't include personal, confidential or sensitive information in this field.
    /// This field may be displayed in plaintext in CloudTrail logs and other
    /// output.
    ///
    /// Tagging or untagging an Amazon Web Services Payment Cryptography key can
    /// allow or deny permission to the key.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .derive_key_usage = "DeriveKeyUsage",
        .enabled = "Enabled",
        .exportable = "Exportable",
        .key_attributes = "KeyAttributes",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .replication_regions = "ReplicationRegions",
        .tags = "Tags",
    };
};

pub const CreateKeyOutput = struct {
    /// The key material that contains all the key attributes.
    key: ?Key = null,

    pub const json_field_names = .{
        .key = "Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKeyInput, options: CallOptions) !CreateKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.CreateKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKeyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateKeyOutput, body, allocator);
}
