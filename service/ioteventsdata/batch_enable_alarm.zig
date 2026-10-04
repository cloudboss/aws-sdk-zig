const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnableAlarmActionRequest = @import("enable_alarm_action_request.zig").EnableAlarmActionRequest;
const BatchAlarmActionErrorEntry = @import("batch_alarm_action_error_entry.zig").BatchAlarmActionErrorEntry;

pub const BatchEnableAlarmInput = struct {
    /// The list of enable action requests. You can specify up to 10 requests per
    /// operation.
    enable_action_requests: []const EnableAlarmActionRequest,

    pub const json_field_names = .{
        .enable_action_requests = "enableActionRequests",
    };
};

pub const BatchEnableAlarmOutput = struct {
    /// A list of errors associated with the request, or `null` if there are no
    /// errors.
    /// Each error entry contains an entry ID that helps you identify the entry that
    /// failed.
    error_entries: ?[]const BatchAlarmActionErrorEntry = null,

    pub const json_field_names = .{
        .error_entries = "errorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchEnableAlarmInput, options: CallOptions) !BatchEnableAlarmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ioteventsdata", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchEnableAlarmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.iotevents", "IoT Events Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/alarms/enable";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"enableActionRequests\":");
    try aws.json.writeValue(@TypeOf(input.enable_action_requests), input.enable_action_requests, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchEnableAlarmOutput {
    var result: BatchEnableAlarmOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchEnableAlarmOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
