const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KmsConfiguration = @import("kms_configuration.zig").KmsConfiguration;

pub const GetTokenVaultInput = struct {
    /// The unique identifier of the token vault to retrieve.
    token_vault_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .token_vault_id = "tokenVaultId",
    };
};

pub const GetTokenVaultOutput = struct {
    /// The KMS configuration for the token vault.
    kms_configuration: ?KmsConfiguration = null,

    /// The timestamp when the token vault was last modified.
    last_modified_date: i64,

    /// The ID of the token vault.
    token_vault_id: []const u8,

    pub const json_field_names = .{
        .kms_configuration = "kmsConfiguration",
        .last_modified_date = "lastModifiedDate",
        .token_vault_id = "tokenVaultId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTokenVaultInput, options: CallOptions) !GetTokenVaultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTokenVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/get-token-vault";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.token_vault_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tokenVaultId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTokenVaultOutput {
    var result: GetTokenVaultOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTokenVaultOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
