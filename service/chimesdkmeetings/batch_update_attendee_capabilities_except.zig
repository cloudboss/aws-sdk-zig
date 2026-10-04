const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttendeeCapabilities = @import("attendee_capabilities.zig").AttendeeCapabilities;
const AttendeeIdItem = @import("attendee_id_item.zig").AttendeeIdItem;

pub const BatchUpdateAttendeeCapabilitiesExceptInput = struct {
    /// The capabilities (`audio`, `video`, or `content`) that you want to update.
    capabilities: AttendeeCapabilities,

    /// The `AttendeeIDs` that you want to exclude from one or more capabilities.
    excluded_attendee_ids: []const AttendeeIdItem,

    /// The ID of the meeting associated with the update request.
    meeting_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .excluded_attendee_ids = "ExcludedAttendeeIds",
        .meeting_id = "MeetingId",
    };
};

pub const BatchUpdateAttendeeCapabilitiesExceptOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateAttendeeCapabilitiesExceptInput, options: CallOptions) !BatchUpdateAttendeeCapabilitiesExceptOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateAttendeeCapabilitiesExceptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("meetings-chime", "Chime SDK Meetings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/meetings/");
    try path_buf.appendSlice(allocator, input.meeting_id);
    try path_buf.appendSlice(allocator, "/attendees/capabilities");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=batch-update-except");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Capabilities\":");
    try aws.json.writeValue(@TypeOf(input.capabilities), input.capabilities, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExcludedAttendeeIds\":");
    try aws.json.writeValue(@TypeOf(input.excluded_attendee_ids), input.excluded_attendee_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateAttendeeCapabilitiesExceptOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: BatchUpdateAttendeeCapabilitiesExceptOutput = .{};

    return result;
}
