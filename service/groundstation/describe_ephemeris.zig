const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEphemerisInput, options: CallOptions) !DescribeEphemerisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEphemerisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ephemeris/");
    try path_buf.appendSlice(allocator, input.ephemeris_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEphemerisOutput {
    const result: DescribeEphemerisOutput = try aws.json.parseJsonObject(
        DescribeEphemerisOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
