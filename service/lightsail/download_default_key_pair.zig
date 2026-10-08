const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DownloadDefaultKeyPairInput = struct {};

pub const DownloadDefaultKeyPairOutput = struct {
    /// The timestamp when the default key pair was created.
    created_at: ?i64 = null,

    /// A base64-encoded RSA private key.
    private_key_base_64: ?[]const u8 = null,

    /// A base64-encoded public key of the `ssh-rsa` type.
    public_key_base_64: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .private_key_base_64 = "privateKeyBase64",
        .public_key_base_64 = "publicKeyBase64",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DownloadDefaultKeyPairInput, options: CallOptions) !DownloadDefaultKeyPairOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DownloadDefaultKeyPairInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.DownloadDefaultKeyPair");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DownloadDefaultKeyPairOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DownloadDefaultKeyPairOutput, body, allocator);
}
