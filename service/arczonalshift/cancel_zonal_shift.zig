const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ZonalShiftStatus = @import("zonal_shift_status.zig").ZonalShiftStatus;

pub const CancelZonalShiftInput = struct {
    /// The internally-generated identifier of a zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .zonal_shift_id = "zonalShiftId",
    };
};

pub const CancelZonalShiftOutput = struct {
    /// The Availability Zone (for example, `use1-az1`) that traffic is moved away
    /// from for a resource when you start a zonal shift. Until the zonal shift
    /// expires or you cancel it, traffic for the resource is instead moved to other
    /// Availability Zones in the Amazon Web Services Region.
    away_from: []const u8,

    /// A comment that you enter about the zonal shift. Only the latest comment is
    /// retained; no comment history is maintained. A new comment overwrites any
    /// existing comment string.
    comment: []const u8,

    /// The expiry time (expiration time) for a customer-initiated zonal shift. A
    /// zonal shift is temporary and must be set to expire when you start the zonal
    /// shift. You can initially set a zonal shift to expire in a maximum of three
    /// days (72 hours). However, you can update a zonal shift to set a new
    /// expiration at any time.
    ///
    /// When you start a zonal shift, you specify how long you want it to be active,
    /// which ARC converts to an expiry time (expiration time). You can cancel a
    /// zonal shift when you're ready to restore traffic to the Availability Zone,
    /// or just wait for it to expire. Or you can update the zonal shift to specify
    /// another length of time to expire in.
    expiry_time: i64,

    /// The identifier for the resource that Amazon Web Services shifts traffic for.
    /// The identifier is the Amazon Resource Name (ARN) for the resource.
    ///
    /// Amazon Application Recovery Controller currently supports enabling the
    /// following resources for zonal shift and zonal autoshift:
    ///
    /// * [Amazon EC2 Auto Scaling
    ///   groups](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.ec2-auto-scaling-groups.html)
    /// * [Amazon Elastic Kubernetes
    ///   Service](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.eks.html)
    /// * [Application Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
    resource_identifier: []const u8,

    /// The time (UTC) when the zonal shift starts.
    start_time: i64,

    /// A status for a zonal shift.
    ///
    /// The `Status` for a zonal shift can have one of the following values:
    ///
    /// * **ACTIVE:** The zonal shift has been started and is active.
    /// * **EXPIRED:** The zonal shift has expired (the expiry time was exceeded).
    /// * **CANCELED:** The zonal shift was canceled.
    status: ZonalShiftStatus,

    /// The identifier of a zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .away_from = "awayFrom",
        .comment = "comment",
        .expiry_time = "expiryTime",
        .resource_identifier = "resourceIdentifier",
        .start_time = "startTime",
        .status = "status",
        .zonal_shift_id = "zonalShiftId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelZonalShiftInput, options: CallOptions) !CancelZonalShiftOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "percdataplane");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelZonalShiftInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/zonalshifts/");
    try path_buf.appendSlice(allocator, input.zonal_shift_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .DELETE;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelZonalShiftOutput {
    var result: CancelZonalShiftOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelZonalShiftOutput, body, allocator);
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
