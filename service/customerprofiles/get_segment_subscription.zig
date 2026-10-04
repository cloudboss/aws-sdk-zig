const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const ScheduledExecutions = @import("scheduled_executions.zig").ScheduledExecutions;
const SegmentSubscriptionStatus = @import("segment_subscription_status.zig").SegmentSubscriptionStatus;

pub const GetSegmentSubscriptionInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique name of the segment definition.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const GetSegmentSubscriptionOutput = struct {
    /// The timestamp of the most recent configuration change.
    last_updated_at: ?i64 = null,

    /// A status message providing additional context, such as a failure reason.
    message: ?[]const u8 = null,

    /// The schedule configuration for periodic membership event notifications.
    schedule_configuration: ?ScheduleConfiguration = null,

    /// Information about scheduled execution timestamps.
    scheduled_executions: ?ScheduledExecutions = null,

    /// The timestamp of when the subscription was first started.
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
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .schedule_configuration = "ScheduleConfiguration",
        .scheduled_executions = "ScheduledExecutions",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentSubscriptionInput, options: CallOptions) !GetSegmentSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-definitions/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentSubscriptionOutput {
    const result: GetSegmentSubscriptionOutput = try aws.json.parseJsonObject(
        GetSegmentSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
