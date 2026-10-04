const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const ScanType = @import("scan_type.zig").ScanType;

pub const GetEncryptionKeyInput = struct {
    /// The resource type the key encrypts.
    resource_type: ResourceType,

    /// The scan type the key encrypts.
    scan_type: ScanType,

    pub const json_field_names = .{
        .resource_type = "resourceType",
        .scan_type = "scanType",
    };
};

pub const GetEncryptionKeyOutput = struct {
    /// A kms key ID.
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEncryptionKeyInput, options: CallOptions) !GetEncryptionKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEncryptionKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/encryptionkey/get";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "scanType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.scan_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEncryptionKeyOutput {
    var result: GetEncryptionKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEncryptionKeyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
