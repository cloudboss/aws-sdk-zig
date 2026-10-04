const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeOperation = @import("attribute_operation.zig").AttributeOperation;

pub const UpdateUserInput = struct {
    /// The globally unique identifier for the identity store.
    ///
    /// You can specify the identity store by ID or by Amazon Resource Name (ARN).
    /// For example, identity store ID `d-1234567890` or identity store ARN
    /// `arn:aws:identitystore::111122223333:identitystore/d-1234567890`.
    identity_store_id: []const u8,

    /// A list of `AttributeOperation` objects to apply to the requested user. These
    /// operations might add, replace, or remove an attribute. For more information
    /// on the attributes that can be added, replaced, or removed, see
    /// [User](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html).
    operations: []const AttributeOperation,

    /// The expected current revision of the user. When you provide this value, the
    /// update is applied only if it matches the current revision of the user in the
    /// identity store, which prevents you from overwriting concurrent changes. If
    /// the value doesn't match, the operation fails with a `ConflictException`. If
    /// you don't provide this value, the update is applied unconditionally.
    revision: ?[]const u8 = null,

    /// The identifier for a user in the identity store.
    ///
    /// You can specify the user by ID or by Amazon Resource Name (ARN). For
    /// example, user ID `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111` or user ARN
    /// `arn:aws:identitystore:::user/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .operations = "Operations",
        .revision = "Revision",
        .user_id = "UserId",
    };
};

pub const UpdateUserOutput = struct {
    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The revision of the user after the requested update is applied.
    revision: []const u8,

    /// The Amazon Resource Name (ARN) of the user in the identity store. For
    /// example,
    /// `arn:aws:identitystore:::user/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_arn: []const u8,

    /// The identifier for a user in the identity store.
    user_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .revision = "Revision",
        .user_arn = "UserArn",
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserInput, options: CallOptions) !UpdateUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.UpdateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateUserOutput, body, allocator);
}
