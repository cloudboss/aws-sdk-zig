const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationDetail = @import("configuration_detail.zig").ConfigurationDetail;
const IdentitySourceDetails = @import("identity_source_details.zig").IdentitySourceDetails;

pub const GetIdentitySourceInput = struct {
    /// Specifies the ID of the identity source you want information about.
    identity_source_id: []const u8,

    /// Specifies the ID of the policy store that contains the identity source you
    /// want information about.
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

    pub const json_field_names = .{
        .identity_source_id = "identitySourceId",
        .policy_store_id = "policyStoreId",
    };
};

pub const GetIdentitySourceOutput = struct {
    /// Contains configuration information about an identity source.
    configuration: ?ConfigurationDetail = null,

    /// The date and time that the identity source was originally created.
    created_date: i64,

    /// A structure that describes the configuration of the identity source.
    details: ?IdentitySourceDetails = null,

    /// The ID of the identity source.
    identity_source_id: []const u8,

    /// The date and time that the identity source was most recently updated.
    last_updated_date: i64,

    /// The ID of the policy store that contains the identity source.
    policy_store_id: []const u8,

    /// The data type of principals generated for identities authenticated by this
    /// identity source.
    principal_entity_type: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .created_date = "createdDate",
        .details = "details",
        .identity_source_id = "identitySourceId",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
        .principal_entity_type = "principalEntityType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentitySourceInput, options: CallOptions) !GetIdentitySourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentitySourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.GetIdentitySource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentitySourceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetIdentitySourceOutput, body, allocator);
}
