const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImpactedLocation = @import("impacted_location.zig").ImpactedLocation;
const HealthEventImpactType = @import("health_event_impact_type.zig").HealthEventImpactType;
const HealthEventStatus = @import("health_event_status.zig").HealthEventStatus;

pub const GetHealthEventInput = struct {
    /// The internally-generated identifier of a health event. Because `EventID`
    /// contains the forward slash (“/”) character, you must
    /// URL-encode the `EventID` field in the request URL.
    event_id: []const u8,

    /// The account ID for an account that you've set up cross-account sharing for
    /// in Amazon CloudWatch Internet Monitor. You configure cross-account
    /// sharing by using Amazon CloudWatch Observability Access Manager. For more
    /// information, see
    /// [Internet Monitor cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cwim-cross-account.html) in the Amazon CloudWatch Internet Monitor User Guide.
    linked_account_id: ?[]const u8 = null,

    /// The name of the monitor.
    monitor_name: []const u8,

    pub const json_field_names = .{
        .event_id = "EventId",
        .linked_account_id = "LinkedAccountId",
        .monitor_name = "MonitorName",
    };
};

pub const GetHealthEventOutput = struct {
    /// The time when a health event was created.
    created_at: ?i64 = null,

    /// The time when a health event was resolved. If the health event is still
    /// active, the end time is not set.
    ended_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the event.
    event_arn: []const u8,

    /// The internally-generated identifier of a health event.
    event_id: []const u8,

    /// The threshold percentage for a health score that determines, along with
    /// other configuration information,
    /// when Internet Monitor creates a health event when there's an internet issue
    /// that affects your application end users.
    health_score_threshold: f64 = 0,

    /// The locations affected by a health event.
    impacted_locations: ?[]const ImpactedLocation = null,

    /// The type of impairment of a specific health event.
    impact_type: HealthEventImpactType,

    /// The time when a health event was last updated or recalculated.
    last_updated_at: i64,

    /// The impact on total traffic that a health event has, in increased latency or
    /// reduced availability. This is the
    /// percentage of how much latency has increased or availability has decreased
    /// during the event, compared to what is typical for traffic from this
    /// client location to the Amazon Web Services location using this client
    /// network.
    percent_of_total_traffic_impacted: ?f64 = null,

    /// The time when a health event started.
    started_at: i64,

    /// The status of a health event.
    status: HealthEventStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .ended_at = "EndedAt",
        .event_arn = "EventArn",
        .event_id = "EventId",
        .health_score_threshold = "HealthScoreThreshold",
        .impacted_locations = "ImpactedLocations",
        .impact_type = "ImpactType",
        .last_updated_at = "LastUpdatedAt",
        .percent_of_total_traffic_impacted = "PercentOfTotalTrafficImpacted",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHealthEventInput, options: Options) !GetHealthEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "internetmonitor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetHealthEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v20210603/Monitors/");
    try path_buf.appendSlice(alloc, input.monitor_name);
    try path_buf.appendSlice(alloc, "/HealthEvents/");
    try path_buf.appendSlice(alloc, input.event_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.linked_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "LinkedAccountId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetHealthEventOutput {
    var result: GetHealthEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetHealthEventOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
