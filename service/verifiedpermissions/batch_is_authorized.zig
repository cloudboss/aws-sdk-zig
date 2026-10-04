const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntitiesDefinition = @import("entities_definition.zig").EntitiesDefinition;
const BatchIsAuthorizedInputItem = @import("batch_is_authorized_input_item.zig").BatchIsAuthorizedInputItem;
const BatchIsAuthorizedOutputItem = @import("batch_is_authorized_output_item.zig").BatchIsAuthorizedOutputItem;

pub const BatchIsAuthorizedInput = struct {
    /// (Optional) Specifies the list of resources and principals and their
    /// associated attributes that Verified Permissions can examine when evaluating
    /// the policies. These additional entities and their attributes can be
    /// referenced and checked by conditional elements in the policies in the
    /// specified policy store.
    ///
    /// You can include only principal and resource entities in this parameter; you
    /// can't include actions. You must specify actions in the schema.
    entities: ?EntitiesDefinition = null,

    /// Specifies the ID of the policy store. Policies in this policy store will be
    /// used to make the authorization decisions for the input.
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

    /// An array of up to 30 requests that you want Verified Permissions to
    /// evaluate.
    requests: []const BatchIsAuthorizedInputItem,

    pub const json_field_names = .{
        .entities = "entities",
        .policy_store_id = "policyStoreId",
        .requests = "requests",
    };
};

pub const BatchIsAuthorizedOutput = struct {
    /// A series of `Allow` or `Deny` decisions for each request, and the policies
    /// that produced them. These results are returned in the order they were
    /// requested.
    results: ?[]const BatchIsAuthorizedOutputItem = null,

    pub const json_field_names = .{
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchIsAuthorizedInput, options: CallOptions) !BatchIsAuthorizedOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchIsAuthorizedInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.BatchIsAuthorized");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchIsAuthorizedOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchIsAuthorizedOutput, body, allocator);
}
