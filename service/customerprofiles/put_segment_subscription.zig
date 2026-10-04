const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const SegmentSubscriptionStatus = @import("segment_subscription_status.zig").SegmentSubscriptionStatus;

pub const PutSegmentSubscriptionInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The optional schedule configuration that controls how often membership
    /// snapshots are run.
    /// If not provided, the subscription defaults to a 24-hour interval.
    schedule_configuration: ?ScheduleConfiguration = null,

    /// The unique name of the segment definition.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .schedule_configuration = "ScheduleConfiguration",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const PutSegmentSubscriptionOutput = struct {
    /// The schedule configuration for the subscription, if configured.
    schedule_configuration: ?ScheduleConfiguration = null,

    /// The timestamp of when the subscription was started.
    started_at: ?i64 = null,

    /// The current lifecycle status of the subscription. The following are valid
    /// values:
    ///
    /// * **STARTING**: Initial snapshot is in progress.
    ///
    /// * **RUNNING**: Notifications are active and running.
    ///
    /// * **STOPPED**: Notifications have been stopped.
    ///
    /// * **FAILED**: Notifications failed (for example, the
    /// Amazon Kinesis data stream became inaccessible).
    status: ?SegmentSubscriptionStatus = null,

    pub const json_field_names = .{
        .schedule_configuration = "ScheduleConfiguration",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSegmentSubscriptionInput, options: CallOptions) !PutSegmentSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSegmentSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-definitions/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.schedule_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScheduleConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSegmentSubscriptionOutput {
    const result: PutSegmentSubscriptionOutput = try aws.json.parseJsonObject(
        PutSegmentSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
