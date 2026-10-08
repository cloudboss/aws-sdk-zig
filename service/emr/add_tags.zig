const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const AddTagsInput = struct {
    /// The ID of the cluster that scopes the tag operation. Required when the
    /// resource being tagged is a session-scoped resource.
    cluster_id: ?[]const u8 = null,

    /// The Amazon EMR resource identifier to which tags will be added. For example,
    /// a
    /// cluster identifier or an Amazon EMR Studio ID.
    resource_id: []const u8,

    /// A list of tags to associate with a resource. Tags are user-defined key-value
    /// pairs that
    /// consist of a required key string with a maximum of 128 characters, and an
    /// optional value
    /// string with a maximum of 256 characters.
    tags: []const Tag,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .resource_id = "ResourceId",
        .tags = "Tags",
    };
};

pub const AddTagsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddTagsInput, options: CallOptions) !AddTagsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.AddTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddTagsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
