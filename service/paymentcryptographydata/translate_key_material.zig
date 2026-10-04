const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncomingKeyMaterial = @import("incoming_key_material.zig").IncomingKeyMaterial;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const OutgoingKeyMaterial = @import("outgoing_key_material.zig").OutgoingKeyMaterial;
const WrappedWorkingKey = @import("wrapped_working_key.zig").WrappedWorkingKey;

pub const TranslateKeyMaterialInput = struct {
    /// Parameter information of the TR31WrappedKeyBlock containing the transaction
    /// key.
    incoming_key_material: IncomingKeyMaterial,

    /// The key check value (KCV) algorithm used for calculating the KCV of the
    /// derived key.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    /// Parameter information of the wrapping key used to wrap the transaction key
    /// in the outgoing TR31WrappedKeyBlock.
    outgoing_key_material: OutgoingKeyMaterial,

    pub const json_field_names = .{
        .incoming_key_material = "IncomingKeyMaterial",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .outgoing_key_material = "OutgoingKeyMaterial",
    };
};

pub const TranslateKeyMaterialOutput = struct {
    /// The outgoing KEK wrapped TR31WrappedKeyBlock.
    wrapped_key: ?WrappedWorkingKey = null,

    pub const json_field_names = .{
        .wrapped_key = "WrappedKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TranslateKeyMaterialInput, options: CallOptions) !TranslateKeyMaterialOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "paymentcryptographydataplane", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TranslateKeyMaterialInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/keymaterial/translate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IncomingKeyMaterial\":");
    try aws.json.writeValue(@TypeOf(input.incoming_key_material), input.incoming_key_material, allocator, &body_buf);
    has_prev = true;
    if (input.key_check_value_algorithm) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KeyCheckValueAlgorithm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutgoingKeyMaterial\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_key_material), input.outgoing_key_material, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TranslateKeyMaterialOutput {
    const result: TranslateKeyMaterialOutput = try aws.json.parseJsonObject(
        TranslateKeyMaterialOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
