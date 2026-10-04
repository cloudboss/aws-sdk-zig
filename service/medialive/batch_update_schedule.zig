const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchScheduleActionCreateRequest = @import("batch_schedule_action_create_request.zig").BatchScheduleActionCreateRequest;
const BatchScheduleActionDeleteRequest = @import("batch_schedule_action_delete_request.zig").BatchScheduleActionDeleteRequest;
const BatchScheduleActionCreateResult = @import("batch_schedule_action_create_result.zig").BatchScheduleActionCreateResult;
const BatchScheduleActionDeleteResult = @import("batch_schedule_action_delete_result.zig").BatchScheduleActionDeleteResult;

pub const BatchUpdateScheduleInput = struct {
    /// Id of the channel whose schedule is being updated.
    channel_id: []const u8,

    /// Schedule actions to create in the schedule.
    creates: ?BatchScheduleActionCreateRequest = null,

    /// Schedule actions to delete from the schedule.
    deletes: ?BatchScheduleActionDeleteRequest = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .creates = "Creates",
        .deletes = "Deletes",
    };
};

pub const BatchUpdateScheduleOutput = struct {
    /// Schedule actions created in the schedule.
    creates: ?BatchScheduleActionCreateResult = null,

    /// Schedule actions deleted from the schedule.
    deletes: ?BatchScheduleActionDeleteResult = null,

    pub const json_field_names = .{
        .creates = "Creates",
        .deletes = "Deletes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateScheduleInput, options: CallOptions) !BatchUpdateScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/channels/");
    try path_buf.appendSlice(allocator, input.channel_id);
    try path_buf.appendSlice(allocator, "/schedule");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.creates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Creates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Deletes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateScheduleOutput {
    var result: BatchUpdateScheduleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateScheduleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
