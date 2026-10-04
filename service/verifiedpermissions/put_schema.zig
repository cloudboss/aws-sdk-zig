const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;

pub const PutSchemaInput = struct {
    /// Specifies the definition of the schema to be stored. The schema definition
    /// must be written in Cedar schema JSON.
    definition: SchemaDefinition,

    /// Specifies the ID of the policy store in which to place the schema.
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
        .definition = "definition",
        .policy_store_id = "policyStoreId",
    };
};

pub const PutSchemaOutput = struct {
    /// The date and time that the schema was originally created.
    created_date: i64,

    /// The date and time that the schema was last updated.
    last_updated_date: i64,

    /// Identifies the namespaces of the entities referenced by this schema.
    namespaces: ?[]const []const u8 = null,

    /// The unique ID of the policy store that contains the schema.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .last_updated_date = "lastUpdatedDate",
        .namespaces = "namespaces",
        .policy_store_id = "policyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSchemaInput, options: CallOptions) !PutSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSchemaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.PutSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSchemaOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutSchemaOutput, body, allocator);
}
