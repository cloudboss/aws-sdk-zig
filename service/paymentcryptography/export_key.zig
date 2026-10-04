const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportAttributes = @import("export_attributes.zig").ExportAttributes;
const ExportKeyMaterial = @import("export_key_material.zig").ExportKeyMaterial;
const WrappedKey = @import("wrapped_key.zig").WrappedKey;

pub const ExportKeyInput = struct {
    /// The attributes for IPEK generation during export.
    export_attributes: ?ExportAttributes = null,

    /// The `KeyARN` of the key under export from Amazon Web Services Payment
    /// Cryptography.
    export_key_identifier: []const u8,

    /// The key block format type, for example, TR-34 or TR-31, to use during key
    /// material export.
    key_material: ExportKeyMaterial,

    pub const json_field_names = .{
        .export_attributes = "ExportAttributes",
        .export_key_identifier = "ExportKeyIdentifier",
        .key_material = "KeyMaterial",
    };
};

pub const ExportKeyOutput = struct {
    /// The key material under export as a TR-34 WrappedKeyBlock or a TR-31
    /// WrappedKeyBlock. or a RSA WrappedKeyCryptogram.
    wrapped_key: ?WrappedKey = null,

    pub const json_field_names = .{
        .wrapped_key = "WrappedKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportKeyInput, options: CallOptions) !ExportKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.ExportKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportKeyOutput, body, allocator);
}
