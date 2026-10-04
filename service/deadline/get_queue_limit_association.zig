const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueueLimitAssociationStatus = @import("queue_limit_association_status.zig").QueueLimitAssociationStatus;

pub const GetQueueLimitAssociationInput = struct {
    /// The unique identifier of the farm that contains the associated queue and
    /// limit.
    farm_id: []const u8,

    /// The unique identifier of the limit associated with the queue.
    limit_id: []const u8,

    /// The unique identifier of the queue associated with the limit.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .limit_id = "limitId",
        .queue_id = "queueId",
    };
};

pub const GetQueueLimitAssociationOutput = struct {
    /// The Unix timestamp of the date and time that the association was created.
    created_at: i64,

    /// The user identifier of the person that created the association.
    created_by: []const u8,

    /// The unique identifier of the limit associated with the queue.
    limit_id: []const u8,

    /// The unique identifier of the queue associated with the limit.
    queue_id: []const u8,

    /// The current status of the limit.
    status: QueueLimitAssociationStatus,

    /// The Unix timestamp of the date and time that the association was last
    /// updated.
    updated_at: ?i64 = null,

    /// The user identifier of the person that last updated the association.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .limit_id = "limitId",
        .queue_id = "queueId",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueLimitAssociationInput, options: CallOptions) !GetQueueLimitAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueLimitAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queue-limit-associations/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.limit_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueLimitAssociationOutput {
    var result: GetQueueLimitAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetQueueLimitAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
