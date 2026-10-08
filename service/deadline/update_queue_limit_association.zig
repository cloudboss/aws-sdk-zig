const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateQueueLimitAssociationStatus = @import("update_queue_limit_association_status.zig").UpdateQueueLimitAssociationStatus;

pub const UpdateQueueLimitAssociationInput = struct {
    /// The unique identifier of the farm that contains the associated queues and
    /// limits.
    farm_id: []const u8,

    /// The unique identifier of the limit associated to the queue.
    limit_id: []const u8,

    /// The unique identifier of the queue associated to the limit.
    queue_id: []const u8,

    /// Sets the status of the limit. You can mark the limit active, or you can stop
    /// usage of the limit and either complete existing tasks or cancel any existing
    /// tasks immediately.
    status: UpdateQueueLimitAssociationStatus,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .limit_id = "limitId",
        .queue_id = "queueId",
        .status = "status",
    };
};

pub const UpdateQueueLimitAssociationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQueueLimitAssociationInput, options: CallOptions) !UpdateQueueLimitAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQueueLimitAssociationInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQueueLimitAssociationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateQueueLimitAssociationOutput = .{};

    return result;
}
