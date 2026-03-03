const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PositionFiltering = @import("position_filtering.zig").PositionFiltering;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const UpdateTrackerInput = struct {
    /// Updates the description for the tracker resource.
    description: ?[]const u8 = null,

    /// Whether to enable position `UPDATE` events from this tracker to be sent to
    /// EventBridge.
    ///
    /// You do not need enable this feature to get `ENTER` and `EXIT` events for
    /// geofences with this tracker. Those events are always sent to EventBridge.
    event_bridge_enabled: ?bool = null,

    /// Enables `GeospatialQueries` for a tracker that uses a [Amazon Web Services
    /// KMS customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html).
    ///
    /// This parameter is only used if you are using a KMS customer managed key.
    kms_key_enable_geospatial_queries: ?bool = null,

    /// Updates the position filtering for the tracker resource.
    ///
    /// Valid values:
    ///
    /// * `TimeBased` - Location updates are evaluated against linked geofence
    ///   collections, but not every location update is stored. If your update
    ///   frequency is more often than 30 seconds, only one update per 30 seconds is
    ///   stored for each unique device ID.
    /// * `DistanceBased` - If the device has moved less than 30 m (98.4 ft),
    ///   location updates are ignored. Location updates within this distance are
    ///   neither evaluated against linked geofence collections, nor stored. This
    ///   helps control costs by reducing the number of geofence evaluations and
    ///   historical device positions to paginate through. Distance-based filtering
    ///   can also reduce the effects of GPS noise when displaying device
    ///   trajectories on a map.
    /// * `AccuracyBased` - If the device has moved less than the measured accuracy,
    ///   location updates are ignored. For example, if two consecutive updates from
    ///   a device have a horizontal accuracy of 5 m and 10 m, the second update is
    ///   ignored if the device has moved less than 15 m. Ignored location updates
    ///   are neither evaluated against linked geofence collections, nor stored.
    ///   This helps educe the effects of GPS noise when displaying device
    ///   trajectories on a map, and can help control costs by reducing the number
    ///   of geofence evaluations.
    position_filtering: ?PositionFiltering = null,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// This parameter is no longer used.
    pricing_plan_data_source: ?[]const u8 = null,

    /// The name of the tracker resource to update.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .event_bridge_enabled = "EventBridgeEnabled",
        .kms_key_enable_geospatial_queries = "KmsKeyEnableGeospatialQueries",
        .position_filtering = "PositionFiltering",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tracker_name = "TrackerName",
    };
};

pub const UpdateTrackerOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated tracker resource. Used to
    /// specify a resource across AWS.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:tracker/ExampleTracker`
    tracker_arn: []const u8,

    /// The name of the updated tracker resource.
    tracker_name: []const u8,

    /// The timestamp for when the tracker resource was last updated in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .tracker_arn = "TrackerArn",
        .tracker_name = "TrackerName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrackerInput, options: CallOptions) !UpdateTrackerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "location");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrackerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("location", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.event_bridge_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EventBridgeEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_enable_geospatial_queries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyEnableGeospatialQueries\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.position_filtering) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PositionFiltering\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan_data_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlanDataSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrackerOutput {
    var result: UpdateTrackerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateTrackerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
