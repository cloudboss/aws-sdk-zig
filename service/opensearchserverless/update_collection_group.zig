const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollectionGroupCapacityLimits = @import("collection_group_capacity_limits.zig").CollectionGroupCapacityLimits;
const UpdateCollectionGroupDetail = @import("update_collection_group_detail.zig").UpdateCollectionGroupDetail;

pub const UpdateCollectionGroupInput = struct {
    /// Updated capacity limits for the collection group, in OpenSearch Compute
    /// Units (OCUs).
    capacity_limits: ?CollectionGroupCapacityLimits = null,

    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A new description for the collection group.
    description: ?[]const u8 = null,

    /// The unique identifier of the collection group to update.
    id: []const u8,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .client_token = "clientToken",
        .description = "description",
        .id = "id",
    };
};

pub const UpdateCollectionGroupOutput = struct {
    /// Details about the updated collection group.
    update_collection_group_detail: ?UpdateCollectionGroupDetail = null,

    pub const json_field_names = .{
        .update_collection_group_detail = "updateCollectionGroupDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCollectionGroupInput, options: CallOptions) !UpdateCollectionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCollectionGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.UpdateCollectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCollectionGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCollectionGroupOutput, body, allocator);
}
