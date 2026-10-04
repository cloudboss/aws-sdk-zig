const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateMeetingDialOutInput = struct {
    /// Phone number used as the caller ID when the remote party receives a call.
    from_phone_number: []const u8,

    /// Token used by the Amazon Chime SDK attendee. Call the
    /// [CreateAttendee](https://docs.aws.amazon.com/chime/latest/APIReference/API_CreateAttendee.html) action to get a join token.
    join_token: []const u8,

    /// The Amazon Chime SDK meeting ID.
    meeting_id: []const u8,

    /// Phone number called when inviting someone to a meeting.
    to_phone_number: []const u8,

    pub const json_field_names = .{
        .from_phone_number = "FromPhoneNumber",
        .join_token = "JoinToken",
        .meeting_id = "MeetingId",
        .to_phone_number = "ToPhoneNumber",
    };
};

pub const CreateMeetingDialOutOutput = struct {
    /// Unique ID that tracks API calls.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .transaction_id = "TransactionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMeetingDialOutInput, options: CallOptions) !CreateMeetingDialOutOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMeetingDialOutInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/meetings/");
    try path_buf.appendSlice(allocator, input.meeting_id);
    try path_buf.appendSlice(allocator, "/dial-outs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromPhoneNumber\":");
    try aws.json.writeValue(@TypeOf(input.from_phone_number), input.from_phone_number, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"JoinToken\":");
    try aws.json.writeValue(@TypeOf(input.join_token), input.join_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ToPhoneNumber\":");
    try aws.json.writeValue(@TypeOf(input.to_phone_number), input.to_phone_number, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMeetingDialOutOutput {
    const result: CreateMeetingDialOutOutput = try aws.json.parseJsonObject(
        CreateMeetingDialOutOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
