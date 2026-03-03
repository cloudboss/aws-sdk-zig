const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PositionFiltering = @import("position_filtering.zig").PositionFiltering;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const CreateTrackerInput = struct {
    /// An optional description for the tracker resource.
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
    ///
    /// If you wish to encrypt your data using your own KMS customer managed key,
    /// then the Bounding Polygon Queries feature will be disabled by default. This
    /// is because by using this feature, a representation of your device positions
    /// will not be encrypted using the your KMS managed key. The exact device
    /// position, however; is still encrypted using your managed key.
    ///
    /// You can choose to opt-in to the Bounding Polygon Quseries feature. This is
    /// done by setting the `KmsKeyEnableGeospatialQueries` parameter to true when
    /// creating or updating a Tracker.
    kms_key_enable_geospatial_queries: ?bool = null,

    /// A key identifier for an [Amazon Web Services KMS customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html). Enter a key ID, key ARN, alias name, or alias ARN.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the position filtering for the tracker resource.
    ///
    /// Valid values:
    ///
    /// * `TimeBased` - Location updates are evaluated against linked geofence
    ///   collections, but not every location update is stored. If your update
    ///   frequency is more often than 30 seconds, only one update per 30 seconds is
    ///   stored for each unique device ID.
    /// * `DistanceBased` - If the device has moved less than 30 m (98.4 ft),
    ///   location updates are ignored. Location updates within this area are
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
    ///   This can reduce the effects of GPS noise when displaying device
    ///   trajectories on a map, and can help control your costs by reducing the
    ///   number of geofence evaluations.
    ///
    /// This field is optional. If not specified, the default value is `TimeBased`.
    position_filtering: ?PositionFiltering = null,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// This parameter is no longer used.
    pricing_plan_data_source: ?[]const u8 = null,

    /// Applies one or more tags to the tracker resource. A tag is a key-value pair
    /// helps manage, identify, search, and filter your resources by labelling them.
    ///
    /// Format: `"key" : "value"`
    ///
    /// Restrictions:
    ///
    /// * Maximum 50 tags per resource
    /// * Each resource tag must be unique with a maximum of one value.
    /// * Maximum key length: 128 Unicode characters in UTF-8
    /// * Maximum value length: 256 Unicode characters in UTF-8
    /// * Can use alphanumeric characters (A–Z, a–z, 0–9), and the following
    ///   characters: + - = . _ : / @.
    /// * Cannot use "aws:" as a prefix for a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name for the tracker resource.
    ///
    /// Requirements:
    ///
    /// * Contain only alphanumeric characters (A-Z, a-z, 0-9) , hyphens (-),
    ///   periods (.), and underscores (_).
    /// * Must be a unique tracker resource name.
    /// * No spaces allowed. For example, `ExampleTracker`.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .event_bridge_enabled = "EventBridgeEnabled",
        .kms_key_enable_geospatial_queries = "KmsKeyEnableGeospatialQueries",
        .kms_key_id = "KmsKeyId",
        .position_filtering = "PositionFiltering",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tags = "Tags",
        .tracker_name = "TrackerName",
    };
};

pub const CreateTrackerOutput = struct {
    /// The timestamp for when the tracker resource was created in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The Amazon Resource Name (ARN) for the tracker resource. Used when you need
    /// to specify a resource across all Amazon Web Services.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:tracker/ExampleTracker`
    tracker_arn: []const u8,

    /// The name of the tracker resource.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .tracker_arn = "TrackerArn",
        .tracker_name = "TrackerName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrackerInput, options: Options) !CreateTrackerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrackerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("location", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/tracking/v0/trackers";

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
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyId\":");
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TrackerName\":");
    try aws.json.writeValue(@TypeOf(input.tracker_name), input.tracker_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrackerOutput {
    var result: CreateTrackerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTrackerOutput, body, allocator);
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
