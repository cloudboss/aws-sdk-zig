const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StateValue = @import("state_value.zig").StateValue;

pub const SetAlarmStateInput = struct {
    /// The name of the alarm.
    alarm_name: []const u8,

    /// The reason that this alarm is set to this specific state, in text format.
    state_reason: []const u8,

    /// The reason that this alarm is set to this specific state, in JSON format.
    ///
    /// For SNS or EC2 alarm actions, this is just informational. But for EC2 Auto
    /// Scaling
    /// or application Auto Scaling alarm actions, the Auto Scaling policy uses the
    /// information
    /// in this field to take the correct action.
    state_reason_data: ?[]const u8 = null,

    /// The value of the state.
    state_value: StateValue,

    pub const json_field_names = .{
        .alarm_name = "AlarmName",
        .state_reason = "StateReason",
        .state_reason_data = "StateReasonData",
        .state_value = "StateValue",
    };
};

pub const SetAlarmStateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetAlarmStateInput, options: CallOptions) !SetAlarmStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetAlarmStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetAlarmState&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&AlarmName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_name);
    try body_buf.appendSlice(allocator, "&StateReason=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.state_reason);
    if (input.state_reason_data) |v| {
        try body_buf.appendSlice(allocator, "&StateReasonData=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StateValue=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.state_value.wireName());

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetAlarmStateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetAlarmStateOutput = .{};

    return result;
}
