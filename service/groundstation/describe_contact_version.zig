const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContactStatus = @import("contact_status.zig").ContactStatus;
const DataflowDetail = @import("dataflow_detail.zig").DataflowDetail;
const EphemerisResponseData = @import("ephemeris_response_data.zig").EphemerisResponseData;
const Elevation = @import("elevation.zig").Elevation;
const TrackingOverrides = @import("tracking_overrides.zig").TrackingOverrides;
const ContactVersion = @import("contact_version.zig").ContactVersion;

pub const DescribeContactVersionInput = struct {
    /// UUID of a contact.
    contact_id: []const u8,

    /// Version ID of a contact.
    version_id: i32,

    pub const json_field_names = .{
        .contact_id = "contactId",
        .version_id = "versionId",
    };
};

pub const DescribeContactVersionOutput = struct {
    /// UUID of a contact.
    contact_id: ?[]const u8 = null,

    /// Status of a contact.
    contact_status: ?ContactStatus = null,

    /// List describing source and destination details for each dataflow edge.
    dataflow_list: ?[]const DataflowDetail = null,

    /// End time of a contact in UTC.
    end_time: ?i64 = null,

    /// The ephemeris that determines antenna pointing directions for the contact.
    ephemeris: ?EphemerisResponseData = null,

    /// Error message for a contact.
    error_message: ?[]const u8 = null,

    /// Ground station for a contact.
    ground_station: ?[]const u8 = null,

    /// Maximum elevation angle of a contact.
    maximum_elevation: ?Elevation = null,

    /// ARN of the contact's mission profile.
    mission_profile_arn: ?[]const u8 = null,

    /// End time in UTC of the post-pass period, at which you receive a CloudWatch
    /// event indicating the pass has finished.
    post_pass_end_time: ?i64 = null,

    /// Start time in UTC of the pre-pass period, at which you receive a CloudWatch
    /// event indicating an upcoming pass.
    pre_pass_start_time: ?i64 = null,

    /// Region where the `ReserveContact` API was called to schedule this contact.
    region: ?[]const u8 = null,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8 = null,

    /// Start time of a contact in UTC.
    start_time: ?i64 = null,

    /// Tags assigned to a contact.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Tracking configuration overrides applied to this contact version. For the
    /// initial version, these are the overrides specified when the contact was
    /// reserved. For subsequent versions, these are the overrides associated with
    /// that specific version update.
    tracking_overrides: ?TrackingOverrides = null,

    /// Version information for a contact.
    version: ?ContactVersion = null,

    /// Projected time in UTC your satellite will set below the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts.
    visibility_end_time: ?i64 = null,

    /// Projected time in UTC your satellite will rise above the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts.
    visibility_start_time: ?i64 = null,

    pub const json_field_names = .{
        .contact_id = "contactId",
        .contact_status = "contactStatus",
        .dataflow_list = "dataflowList",
        .end_time = "endTime",
        .ephemeris = "ephemeris",
        .error_message = "errorMessage",
        .ground_station = "groundStation",
        .maximum_elevation = "maximumElevation",
        .mission_profile_arn = "missionProfileArn",
        .post_pass_end_time = "postPassEndTime",
        .pre_pass_start_time = "prePassStartTime",
        .region = "region",
        .satellite_arn = "satelliteArn",
        .start_time = "startTime",
        .tags = "tags",
        .tracking_overrides = "trackingOverrides",
        .version = "version",
        .visibility_end_time = "visibilityEndTime",
        .visibility_start_time = "visibilityStartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeContactVersionInput, options: CallOptions) !DescribeContactVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "groundstation");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeContactVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/contact/");
    try path_buf.appendSlice(allocator, input.contact_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeContactVersionOutput {
    var result: DescribeContactVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeContactVersionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DependencyException")) {
        return .{ .arena = arena, .kind = .{ .dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
