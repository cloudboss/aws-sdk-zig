const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const Event = @import("event.zig").Event;

pub const CreateEventActionInput = struct {
    /// What occurs after a certain event.
    action: Action,

    /// What occurs to start an action.
    event: Event,

    /// Key-value pairs that you can associate with the event action.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "Action",
        .event = "Event",
        .tags = "Tags",
    };
};

pub const CreateEventActionOutput = struct {
    /// What occurs after a certain event.
    action: ?Action = null,

    /// The ARN for the event action.
    arn: ?[]const u8 = null,

    /// The date and time that the event action was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// What occurs to start an action.
    event: ?Event = null,

    /// The unique identifier for the event action.
    id: ?[]const u8 = null,

    /// The tags for the event action.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time that the event action was last updated, in ISO 8601
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .action = "Action",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .event = "Event",
        .id = "Id",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventActionInput, options: CallOptions) !CreateEventActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/event-actions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Event\":");
    try aws.json.writeValue(@TypeOf(input.event), input.event, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventActionOutput {
    var result: CreateEventActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEventActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
