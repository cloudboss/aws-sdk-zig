const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Configuration = @import("configuration.zig").Configuration;

pub const CreateIdentitySourceInput = struct {
    /// Specifies a unique, case-sensitive ID that you provide to ensure the
    /// idempotency of the request. This lets you safely retry the request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a later call to an operation requires that you also pass the same
    /// value for all other parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `ConflictException` error.
    ///
    /// Verified Permissions recognizes a `ClientToken` for eight hours. After eight
    /// hours, the next request with the same parameters performs the operation
    /// again regardless of the value of `ClientToken`.
    client_token: ?[]const u8 = null,

    /// Specifies the details required to communicate with the identity provider
    /// (IdP) associated with this identity source.
    configuration: Configuration,

    /// Specifies the ID of the policy store in which you want to store this
    /// identity source. Only policies and requests made using this policy store can
    /// reference identities from the identity provider configured in the new
    /// identity source.
    ///
    /// To specify a policy store, use its ID or alias name. When using an alias
    /// name, prefix it with `policy-store-alias/`. For example:
    ///
    /// * ID: `PSEXAMPLEabcdefg111111`
    /// * Alias name: `policy-store-alias/example-policy-store`
    ///
    /// To view aliases, use
    /// [ListPolicyStoreAliases](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyStoreAliases.html).
    policy_store_id: []const u8,

    /// Specifies the namespace and data type of the principals generated for
    /// identities authenticated by the new identity source.
    principal_entity_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .configuration = "configuration",
        .policy_store_id = "policyStoreId",
        .principal_entity_type = "principalEntityType",
    };
};

pub const CreateIdentitySourceOutput = struct {
    /// The date and time the identity source was originally created.
    created_date: i64,

    /// The unique ID of the new identity source.
    identity_source_id: []const u8,

    /// The date and time the identity source was most recently updated.
    last_updated_date: i64,

    /// The ID of the policy store that contains the identity source.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .identity_source_id = "identitySourceId",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdentitySourceInput, options: CallOptions) !CreateIdentitySourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIdentitySourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.CreateIdentitySource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIdentitySourceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIdentitySourceOutput, body, allocator);
}
