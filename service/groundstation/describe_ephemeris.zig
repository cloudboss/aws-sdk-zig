const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EphemerisErrorReason = @import("ephemeris_error_reason.zig").EphemerisErrorReason;
const EphemerisInvalidReason = @import("ephemeris_invalid_reason.zig").EphemerisInvalidReason;
const EphemerisStatus = @import("ephemeris_status.zig").EphemerisStatus;
const EphemerisTypeDescription = @import("ephemeris_type_description.zig").EphemerisTypeDescription;

pub const DescribeEphemerisInput = struct {
    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: []const u8,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};

pub const DescribeEphemerisOutput = struct {
    /// The time the ephemeris was uploaded in UTC.
    creation_time: ?i64 = null,

    /// Whether or not the ephemeris is enabled.
    enabled: ?bool = null,

    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: ?[]const u8 = null,

    /// Detailed error information for ephemerides with `INVALID` status.
    ///
    /// Provides specific error codes and messages to help diagnose validation
    /// failures.
    error_reasons: ?[]const EphemerisErrorReason = null,

    /// Reason that an ephemeris failed validation. Appears only when the status is
    /// `INVALID`.
    invalid_reason: ?EphemerisInvalidReason = null,

    /// A name that you can use to identify the ephemeris.
    name: ?[]const u8 = null,

    /// A priority score that determines which ephemeris to use when multiple
    /// ephemerides overlap.
    ///
    /// Higher numbers take precedence. The default is 1. Must be 1 or greater.
    priority: ?i32 = null,

    /// The AWS Ground Station satellite ID associated with ephemeris.
    satellite_id: ?[]const u8 = null,

    /// The status of the ephemeris.
    status: ?EphemerisStatus = null,

    /// Supplied ephemeris data.
    supplied_data: ?EphemerisTypeDescription = null,

    /// Tags assigned to an ephemeris.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .enabled = "enabled",
        .ephemeris_id = "ephemerisId",
        .error_reasons = "errorReasons",
        .invalid_reason = "invalidReason",
        .name = "name",
        .priority = "priority",
        .satellite_id = "satelliteId",
        .status = "status",
        .supplied_data = "suppliedData",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEphemerisInput, options: Options) !DescribeEphemerisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEphemerisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/ephemeris/");
    try path_buf.appendSlice(allocator, input.ephemeris_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEphemerisOutput {
    var result: DescribeEphemerisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeEphemerisOutput, body, allocator);
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
