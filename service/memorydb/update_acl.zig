const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ACL = @import("acl.zig").ACL;

pub const UpdateACLInput = struct {
    /// The name of the Access Control List.
    acl_name: []const u8,

    /// The list of users to add to the Access Control List.
    user_names_to_add: ?[]const []const u8 = null,

    /// The list of users to remove from the Access Control List.
    user_names_to_remove: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .acl_name = "ACLName",
        .user_names_to_add = "UserNamesToAdd",
        .user_names_to_remove = "UserNamesToRemove",
    };
};

pub const UpdateACLOutput = struct {
    /// The updated Access Control List.
    acl: ?ACL = null,

    pub const json_field_names = .{
        .acl = "ACL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateACLInput, options: CallOptions) !UpdateACLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.UpdateACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateACLOutput, body, allocator);
}
