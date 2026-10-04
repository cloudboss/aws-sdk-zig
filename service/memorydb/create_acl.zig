const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ACL = @import("acl.zig").ACL;

pub const CreateACLInput = struct {
    /// The name of the Access Control List.
    acl_name: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,

    /// The list of users that belong to the Access Control List.
    user_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .acl_name = "ACLName",
        .tags = "Tags",
        .user_names = "UserNames",
    };
};

pub const CreateACLOutput = struct {
    /// The newly-created Access Control List.
    acl: ?ACL = null,

    pub const json_field_names = .{
        .acl = "ACL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateACLInput, options: CallOptions) !CreateACLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateACLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.CreateACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateACLOutput, body, allocator);
}
