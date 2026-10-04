const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollectionGroupDetail = @import("collection_group_detail.zig").CollectionGroupDetail;
const CollectionGroupErrorDetail = @import("collection_group_error_detail.zig").CollectionGroupErrorDetail;

pub const BatchGetCollectionGroupInput = struct {
    /// A list of collection group IDs. You can't provide names and IDs in the same
    /// request.
    ids: ?[]const []const u8 = null,

    /// A list of collection group names. You can't provide names and IDs in the
    /// same request.
    names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
        .names = "names",
    };
};

pub const BatchGetCollectionGroupOutput = struct {
    /// Details about each collection group.
    collection_group_details: ?[]const CollectionGroupDetail = null,

    /// Error information for the request.
    collection_group_error_details: ?[]const CollectionGroupErrorDetail = null,

    pub const json_field_names = .{
        .collection_group_details = "collectionGroupDetails",
        .collection_group_error_details = "collectionGroupErrorDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCollectionGroupInput, options: CallOptions) !BatchGetCollectionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCollectionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.BatchGetCollectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCollectionGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetCollectionGroupOutput, body, allocator);
}
