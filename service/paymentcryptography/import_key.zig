const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    /// The key or public key certificate type to use during key material import,
    /// for example TR-34 or RootCertificatePublicKey.
    key_material: ImportKeyMaterial,

    replication_regions: ?[]const []const u8 = null,

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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportKeyInput, options: Options) !ImportKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "paymentcryptography");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ImportKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptography", "Payment Cryptography", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
