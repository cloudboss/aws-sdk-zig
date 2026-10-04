const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ImportSshPublicKeyInput = struct {
    /// A system-assigned unique identifier for a server.
    server_id: []const u8,

    /// The public key portion of an SSH key pair.
    ///
    /// Transfer Family accepts RSA, ECDSA, and ED25519 keys.
    ssh_public_key_body: []const u8,

    /// The name of the Transfer Family user that is assigned to one or more
    /// servers.
    user_name: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .ssh_public_key_body = "SshPublicKeyBody",
        .user_name = "UserName",
    };
};

pub const ImportSshPublicKeyOutput = struct {
    /// A system-assigned unique identifier for a server.
    server_id: []const u8,

    /// The name given to a public key by the system that was imported.
    ssh_public_key_id: []const u8,

    /// A user name assigned to the `ServerID` value that you specified.
    user_name: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .ssh_public_key_id = "SshPublicKeyId",
        .user_name = "UserName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportSshPublicKeyInput, options: CallOptions) !ImportSshPublicKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportSshPublicKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ImportSshPublicKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportSshPublicKeyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportSshPublicKeyOutput, body, allocator);
}
