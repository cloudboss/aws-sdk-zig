const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

    /// The wrapping key algorithm to generate a wrapping key certificate. This
    /// certificate wraps the key under import.
    ///
    /// At this time, `RSA_2048` is the allowed algorithm for TR-34 WrappedKeyBlock
    /// import. Additionally, `RSA_2048`, `RSA_3072`, `RSA_4096` are the allowed
    /// algorithms for RSA WrappedKeyCryptogram import.
    wrapping_key_algorithm: KeyAlgorithm,

    pub const json_field_names = .{
        .key_material_type = "KeyMaterialType",
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParametersForImportInput, options: Options) !GetParametersForImportOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetParametersForImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptography", "Payment Cryptography", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "PaymentCryptographyControlPlane.GetParametersForImport");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetParametersForImportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetParametersForImportOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
