const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExternalId = @import("external_id.zig").ExternalId;

pub const DescribeGroupInput = struct {
    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store, such as
    /// `d-1234567890`. In this example, `d-` is a fixed prefix, and `1234567890` is
    /// a randomly generated string that contains numbers and lower case letters.
    /// This value is generated at the time that a new identity store is created.
    identity_store_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
    };
};

pub const DescribeGroupOutput = struct {
    /// The date and time the group was created.
    created_at: ?i64 = null,

    /// The identifier of the user or system that created the group.
    created_by: ?[]const u8 = null,

    /// A string containing a description of the group.
    description: ?[]const u8 = null,

    /// The group’s display name value. The length limit is 1,024 characters. This
    /// value can consist of letters, accented characters, symbols, numbers,
    /// punctuation, tab, new line, carriage return, space, and nonbreaking space in
    /// this attribute. This value is specified at the time that the group is
    /// created and stored as an attribute of the group object in the identity
    /// store.
    display_name: ?[]const u8 = null,

    /// A list of `ExternalId` objects that contains the identifiers issued to this
    /// resource by an external identity provider.
    external_ids: ?[]const ExternalId = null,

    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The date and time the group was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user or system that last updated the group.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .display_name = "DisplayName",
        .external_ids = "ExternalIds",
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGroupInput, options: CallOptions) !DescribeGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.DescribeGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeGroupOutput, body, allocator);
}
