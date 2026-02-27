const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ZonalShiftStatus = @import("zonal_shift_status.zig").ZonalShiftStatus;

pub const UpdateZonalShiftInput = struct {
    /// A comment that you enter about the zonal shift. Only the latest comment is
    /// retained; no comment history is maintained. A new comment overwrites any
    /// existing comment string.
    comment: ?[]const u8 = null,

    /// The length of time that you want a zonal shift to be active, which ARC
    /// converts to an expiry time (expiration time). Zonal shifts are temporary.
    /// You can set a zonal shift to be active initially for up to three days (72
    /// hours).
    ///
    /// If you want to still keep traffic away from an Availability Zone, you can
    /// update the zonal shift and set a new expiration. You can also cancel a zonal
    /// shift, before it expires, for example, if you're ready to restore traffic to
    /// the Availability Zone.
    ///
    /// To set a length of time for a zonal shift to be active, specify a whole
    /// number, and then one of the following, with no space:
    ///
    /// * **A lowercase letter m:** To specify that the value is in minutes.
    /// * **A lowercase letter h:** To specify that the value is in hours.
    ///
    /// For example: `20h` means the zonal shift expires in 20 hours. `120m` means
    /// the zonal shift expires in 120 minutes (2 hours).
    expires_in: ?[]const u8 = null,

    /// The identifier of a zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .expires_in = "expiresIn",
        .zonal_shift_id = "zonalShiftId",
    };
};

pub const UpdateZonalShiftOutput = struct {
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateZonalShiftInput, options: Options) !UpdateZonalShiftOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "arczonalshift");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateZonalShiftInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arczonalshift", "ARC Zonal Shift", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/zonalshifts/");
    try path_buf.appendSlice(alloc, input.zonal_shift_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.expires_in) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"expiresIn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateZonalShiftOutput {
    var result: UpdateZonalShiftOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateZonalShiftOutput, body, alloc);
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
