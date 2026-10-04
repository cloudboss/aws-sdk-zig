const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteCollectionDetail = @import("delete_collection_detail.zig").DeleteCollectionDetail;

pub const DeleteCollectionInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the collection. For example, `1iu5usc406kd`. The ID
    /// is part of the collection endpoint. You can also retrieve it using the
    /// [ListCollections](https://docs.aws.amazon.com/opensearch-service/latest/ServerlessAPIReference/API_ListCollections.html) API.
    id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
    };
};

pub const DeleteCollectionOutput = struct {
    /// Details of the deleted collection.
    delete_collection_detail: ?DeleteCollectionDetail = null,

    pub const json_field_names = .{
        .delete_collection_detail = "deleteCollectionDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCollectionInput, options: CallOptions) !DeleteCollectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCollectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.DeleteCollection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCollectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteCollectionOutput, body, allocator);
}
