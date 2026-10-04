const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const ScanType = @import("scan_type.zig").ScanType;

pub const UpdateEncryptionKeyInput = struct {
    /// A KMS key ID for the encryption key.
    kms_key_id: []const u8,

    /// The resource type for the encryption key.
    resource_type: ResourceType,

    /// The scan type for the encryption key.
    scan_type: ScanType,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .resource_type = "resourceType",
        .scan_type = "scanType",
    };
};

pub const UpdateEncryptionKeyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEncryptionKeyInput, options: CallOptions) !UpdateEncryptionKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEncryptionKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/encryptionkey/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
    try aws.json.writeValue(@TypeOf(input.kms_key_id), input.kms_key_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanType\":");
    try aws.json.writeValue(@TypeOf(input.scan_type), input.scan_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEncryptionKeyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateEncryptionKeyOutput = .{};

    return result;
}
