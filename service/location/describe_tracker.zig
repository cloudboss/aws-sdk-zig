const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PositionFiltering = @import("position_filtering.zig").PositionFiltering;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const DescribeTrackerInput = struct {
    /// The name of the tracker resource.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .tracker_name = "TrackerName",
    };
};

pub const DescribeTrackerOutput = struct {
    /// The timestamp for when the tracker resource was created in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The optional description for the tracker resource.
    description: []const u8,

    /// Whether `UPDATE` events from this tracker in EventBridge are enabled. If set
    /// to `true` these events will be sent to EventBridge.
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
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html)
    /// assigned to the Amazon Location resource.
    kms_key_id: ?[]const u8 = null,

    /// The position filtering method of the tracker resource.
    position_filtering: ?PositionFiltering = null,

    /// Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// No longer used. Always returns an empty string.
    pricing_plan_data_source: ?[]const u8 = null,

    /// The tags associated with the tracker resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) for the tracker resource. Used when you need
    /// to specify a resource across all Amazon Web Services.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:tracker/ExampleTracker`
    tracker_arn: []const u8,

    /// The name of the tracker resource.
    tracker_name: []const u8,

    /// The timestamp for when the tracker resource was last updated in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .description = "Description",
        .event_bridge_enabled = "EventBridgeEnabled",
        .kms_key_enable_geospatial_queries = "KmsKeyEnableGeospatialQueries",
        .kms_key_id = "KmsKeyId",
        .position_filtering = "PositionFiltering",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tags = "Tags",
        .tracker_arn = "TrackerArn",
        .tracker_name = "TrackerName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrackerInput, options: CallOptions) !DescribeTrackerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrackerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrackerOutput {
    var result: DescribeTrackerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeTrackerOutput, body, allocator);
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
