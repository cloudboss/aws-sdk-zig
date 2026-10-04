const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateAttendeeRequestItem = @import("create_attendee_request_item.zig").CreateAttendeeRequestItem;
const Attendee = @import("attendee.zig").Attendee;
const CreateAttendeeError = @import("create_attendee_error.zig").CreateAttendeeError;

pub const BatchCreateAttendeeInput = struct {
    /// The attendee information, including attendees' IDs and join tokens.
    attendees: []const CreateAttendeeRequestItem,

    /// The Amazon Chime SDK ID of the meeting to which you're adding attendees.
    meeting_id: []const u8,

    pub const json_field_names = .{
        .attendees = "Attendees",
        .meeting_id = "MeetingId",
    };
};

pub const BatchCreateAttendeeOutput = struct {
    /// The attendee information, including attendees' IDs and join tokens.
    attendees: ?[]const Attendee = null,

    /// If the action fails for one or more of the attendees in the request, a list
    /// of the attendees is returned, along with error codes and error messages.
    errors: ?[]const CreateAttendeeError = null,

    pub const json_field_names = .{
        .attendees = "Attendees",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateAttendeeInput, options: CallOptions) !BatchCreateAttendeeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateAttendeeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("meetings-chime", "Chime SDK Meetings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/meetings/");
    try path_buf.appendSlice(allocator, input.meeting_id);
    try path_buf.appendSlice(allocator, "/attendees");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=batch-create");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Attendees\":");
    try aws.json.writeValue(@TypeOf(input.attendees), input.attendees, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateAttendeeOutput {
    var result: BatchCreateAttendeeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchCreateAttendeeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
