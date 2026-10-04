const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreatePolicyStoreAliasInput = struct {
    /// Specifies the name of the policy store alias to create. The name must be
    /// unique within your Amazon Web Services account and Amazon Web Services
    /// Region.
    ///
    /// The alias name must always be prefixed with `policy-store-alias/`.
    alias_name: []const u8,

    /// Specifies the ID of the policy store to associate with the alias.
    ///
    /// The associated policy store must be specified using its ID. The alias name
    /// cannot be used.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .alias_name = "aliasName",
        .policy_store_id = "policyStoreId",
    };
};

pub const CreatePolicyStoreAliasOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy store alias.
    alias_arn: []const u8,

    /// The name of the policy store alias.
    alias_name: []const u8,

    /// The date and time the policy store alias was created.
    created_at: i64,

    /// The ID of the policy store associated with the alias.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .alias_arn = "aliasArn",
        .alias_name = "aliasName",
        .created_at = "createdAt",
        .policy_store_id = "policyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyStoreAliasInput, options: CallOptions) !CreatePolicyStoreAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "verifiedpermissions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyStoreAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.CreatePolicyStoreAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyStoreAliasOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePolicyStoreAliasOutput, body, allocator);
}
