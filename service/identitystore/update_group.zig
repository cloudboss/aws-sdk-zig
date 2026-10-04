const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeOperation = @import("attribute_operation.zig").AttributeOperation;

pub const UpdateGroupInput = struct {
    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// A list of `AttributeOperation` objects to apply to the requested group.
    /// These operations might add, replace, or remove an attribute. For more
    /// information on the attributes that can be added, replaced, or removed, see
    /// [Group](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html).
    operations: []const AttributeOperation,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .operations = "Operations",
    };
};

pub const UpdateGroupOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGroupInput, options: CallOptions) !UpdateGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "identitystore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identitystore", "identitystore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.UpdateGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
