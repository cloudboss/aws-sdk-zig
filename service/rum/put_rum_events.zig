const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppMonitorDetails = @import("app_monitor_details.zig").AppMonitorDetails;
const RumEvent = @import("rum_event.zig").RumEvent;
const UserDetails = @import("user_details.zig").UserDetails;

pub const PutRumEventsInput = struct {
    /// If the app monitor uses a resource-based policy that requires `PutRumEvents`
    /// requests to specify a certain alias, specify that alias here. This alias
    /// will be compared to the `rum:alias` context key in the resource-based
    /// policy. For more information, see [Using resource-based policies with
    /// CloudWatch
    /// RUM](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-resource-policies.html).
    alias: ?[]const u8 = null,

    /// A structure that contains information about the app monitor that collected
    /// this telemetry information.
    app_monitor_details: AppMonitorDetails,

    /// A unique identifier for this batch of RUM event data.
    batch_id: []const u8,

    /// The ID of the app monitor that is sending this data.
    id: []const u8,

    /// An array of structures that contain the telemetry event data.
    rum_events: []const RumEvent,

    /// A structure that contains information about the user session that this batch
    /// of events was collected from.
    user_details: UserDetails,

    pub const json_field_names = .{
        .alias = "Alias",
        .app_monitor_details = "AppMonitorDetails",
        .batch_id = "BatchId",
        .id = "Id",
        .rum_events = "RumEvents",
        .user_details = "UserDetails",
    };
};

pub const PutRumEventsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRumEventsInput, options: CallOptions) !PutRumEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRumEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appmonitors/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Alias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AppMonitorDetails\":");
    try aws.json.writeValue(@TypeOf(input.app_monitor_details), input.app_monitor_details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BatchId\":");
    try aws.json.writeValue(@TypeOf(input.batch_id), input.batch_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RumEvents\":");
    try aws.json.writeValue(@TypeOf(input.rum_events), input.rum_events, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UserDetails\":");
    try aws.json.writeValue(@TypeOf(input.user_details), input.user_details, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRumEventsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutRumEventsOutput = .{};

    return result;
}
