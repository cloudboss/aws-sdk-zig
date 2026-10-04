const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CalendarState = @import("calendar_state.zig").CalendarState;

pub const GetCalendarStateInput = struct {
    /// (Optional) The specific time for which you want to get calendar state
    /// information, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// If you don't specify a
    /// value or `AtTime`, the current time is used.
    at_time: ?[]const u8 = null,

    /// The names of Amazon Resource Names (ARNs) of the Systems Manager documents
    /// (SSM documents) that
    /// represent the calendar entries for which you want to get the state.
    calendar_names: []const []const u8,

    pub const json_field_names = .{
        .at_time = "AtTime",
        .calendar_names = "CalendarNames",
    };
};

pub const GetCalendarStateOutput = struct {
    /// The time, as an [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) string,
    /// that you specified in your command. If you don't specify a time,
    /// `GetCalendarState`
    /// uses the current time.
    at_time: ?[]const u8 = null,

    /// The time, as an [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) string,
    /// that the calendar state will change. If the current calendar state is
    /// `OPEN`,
    /// `NextTransitionTime` indicates when the calendar state changes to
    /// `CLOSED`, and vice-versa.
    next_transition_time: ?[]const u8 = null,

    /// The state of the calendar. An `OPEN` calendar indicates that actions are
    /// allowed
    /// to proceed, and a `CLOSED` calendar indicates that actions aren't allowed to
    /// proceed.
    state: ?CalendarState = null,

    pub const json_field_names = .{
        .at_time = "AtTime",
        .next_transition_time = "NextTransitionTime",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCalendarStateInput, options: CallOptions) !GetCalendarStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCalendarStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetCalendarState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCalendarStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCalendarStateOutput, body, allocator);
}
