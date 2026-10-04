const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ImportHostKeyInput = struct {
    /// The text description that identifies this host key.
    description: ?[]const u8 = null,

    /// The private key portion of an SSH key pair.
    ///
    /// Transfer Family accepts RSA, ECDSA, and ED25519 keys.
    host_key_body: []const u8,

    /// The identifier of the server that contains the host key that you are
    /// importing.
    server_id: []const u8,

    /// Key-value pairs that can be used to group and search for host keys.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .host_key_body = "HostKeyBody",
        .server_id = "ServerId",
        .tags = "Tags",
    };
};

pub const ImportHostKeyOutput = struct {
    /// Returns the host key identifier for the imported key.
    host_key_id: []const u8,

    /// Returns the server identifier that contains the imported key.
    server_id: []const u8,

    pub const json_field_names = .{
        .host_key_id = "HostKeyId",
        .server_id = "ServerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportHostKeyInput, options: CallOptions) !ImportHostKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportHostKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ImportHostKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportHostKeyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportHostKeyOutput, body, allocator);
}
