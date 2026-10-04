const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScanDirection = @import("scan_direction.zig").ScanDirection;
const SortKey = @import("sort_key.zig").SortKey;
const StartPosition = @import("start_position.zig").StartPosition;
const Item = @import("item.zig").Item;

pub const GetTranscriptInput = struct {
    /// The authentication token associated with the participant's connection.
    connection_token: []const u8,

    /// The contactId from the current contact chain for which transcript is needed.
    contact_id: ?[]const u8 = null,

    /// The maximum number of results to return in the page. Default: 10.
    max_results: ?i32 = null,

    /// The pagination token. Use the value returned previously in the next
    /// subsequent request
    /// to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The direction from StartPosition from which to retrieve message. Default:
    /// BACKWARD
    /// when no StartPosition is provided, FORWARD with StartPosition.
    scan_direction: ?ScanDirection = null,

    /// The sort order for the records. Default: DESCENDING.
    sort_order: ?SortKey = null,

    /// A filtering option for where to start.
    start_position: ?StartPosition = null,

    pub const json_field_names = .{
        .connection_token = "ConnectionToken",
        .contact_id = "ContactId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .scan_direction = "ScanDirection",
        .sort_order = "SortOrder",
        .start_position = "StartPosition",
    };
};

pub const GetTranscriptOutput = struct {
    /// The initial contact ID for the contact.
    initial_contact_id: ?[]const u8 = null,

    /// The pagination token. Use the value returned previously in the next
    /// subsequent request
    /// to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The list of messages in the session.
    transcript: ?[]const Item = null,

    pub const json_field_names = .{
        .initial_contact_id = "InitialContactId",
        .next_token = "NextToken",
        .transcript = "Transcript",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTranscriptInput, options: CallOptions) !GetTranscriptOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTranscriptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("participant.connect", "ConnectParticipant", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/participant/transcript";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scan_direction) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScanDirection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start_position) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartPosition\":");
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
    try request.headers.put(allocator, "X-Amz-Bearer", input.connection_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTranscriptOutput {
    const result: GetTranscriptOutput = try aws.json.parseJsonObject(
        GetTranscriptOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
