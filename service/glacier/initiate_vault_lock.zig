const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VaultLockPolicy = @import("vault_lock_policy.zig").VaultLockPolicy;

pub const InitiateVaultLockInput = struct {
    /// The `AccountId` value is the AWS account ID. This value must match the AWS
    /// account ID associated with the credentials used to sign the request. You can
    /// either specify
    /// an AWS account ID or optionally a single '`-`' (hyphen), in which case
    /// Amazon
    /// Glacier uses the AWS account ID associated with the credentials used to sign
    /// the request.
    /// If you specify your account ID, do not include any hyphens ('-') in the ID.
    account_id: []const u8,

    /// The vault lock policy as a JSON string, which uses "\" as an escape
    /// character.
    policy: ?VaultLockPolicy = null,

    /// The name of the vault.
    vault_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .policy = "policy",
        .vault_name = "vaultName",
    };
};

pub const InitiateVaultLockOutput = struct {
    /// The lock ID, which is used to complete the vault locking process.
    lock_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lock_id = "lockId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitiateVaultLockInput, options: CallOptions) !InitiateVaultLockOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glacier", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InitiateVaultLockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/vaults/");
    try path_buf.appendSlice(allocator, input.vault_name);
    try path_buf.appendSlice(allocator, "/lock-policy");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = if (input.policy) |v| try aws.json.jsonStringify(v, allocator) else null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitiateVaultLockOutput {
    var result: InitiateVaultLockOutput = .{};
    errdefer {
        if (result.lock_id) |value| allocator.free(value);
    }
    _ = body;
    _ = status;
    if (headers.get("x-amz-lock-id")) |value| {
        result.lock_id = try allocator.dupe(u8, value);
    }

    return result;
}
