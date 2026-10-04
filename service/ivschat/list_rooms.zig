const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoomSummary = @import("room_summary.zig").RoomSummary;

pub const ListRoomsInput = struct {
    /// Logging-configuration identifier.
    logging_configuration_identifier: ?[]const u8 = null,

    /// Maximum number of rooms to return. Default: 50.
    max_results: ?i32 = null,

    /// Filters the list to match the specified message review handler URI.
    message_review_handler_uri: ?[]const u8 = null,

    /// Filters the list to match the specified room name.
    name: ?[]const u8 = null,

    /// The first room to retrieve. This is used for pagination; see the `nextToken`
    /// response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .logging_configuration_identifier = "loggingConfigurationIdentifier",
        .max_results = "maxResults",
        .message_review_handler_uri = "messageReviewHandlerUri",
        .name = "name",
        .next_token = "nextToken",
    };
};

pub const ListRoomsOutput = struct {
    /// If there are more rooms than `maxResults`, use `nextToken` in the
    /// request to get the next set.
    next_token: ?[]const u8 = null,

    /// List of the matching rooms (summary information only).
    rooms: ?[]const RoomSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .rooms = "rooms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRoomsInput, options: CallOptions) !ListRoomsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivschat", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRoomsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivschat", "ivschat", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListRooms";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.logging_configuration_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"loggingConfigurationIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.message_review_handler_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"messageReviewHandlerUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRoomsOutput {
    var result: ListRoomsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRoomsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
