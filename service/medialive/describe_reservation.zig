const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OfferingDurationUnits = @import("offering_duration_units.zig").OfferingDurationUnits;
const OfferingType = @import("offering_type.zig").OfferingType;
const RenewalSettings = @import("renewal_settings.zig").RenewalSettings;
const ReservationResourceSpecification = @import("reservation_resource_specification.zig").ReservationResourceSpecification;
const ReservationState = @import("reservation_state.zig").ReservationState;

pub const DescribeReservationInput = struct {
    /// Unique reservation ID, e.g. '1234567'
    reservation_id: []const u8,

    pub const json_field_names = .{
        .reservation_id = "ReservationId",
    };
};

pub const DescribeReservationOutput = struct {
    /// Unique reservation ARN, e.g.
    /// 'arn:aws:medialive:us-west-2:123456789012:reservation:1234567'
    arn: ?[]const u8 = null,

    /// Number of reserved resources
    count: ?i32 = null,

    /// Currency code for usagePrice and fixedPrice in ISO-4217 format, e.g. 'USD'
    currency_code: ?[]const u8 = null,

    /// Lease duration, e.g. '12'
    duration: ?i32 = null,

    /// Units for duration, e.g. 'MONTHS'
    duration_units: ?OfferingDurationUnits = null,

    /// Reservation UTC end date and time in ISO-8601 format, e.g.
    /// '2019-03-01T00:00:00'
    end: ?[]const u8 = null,

    /// One-time charge for each reserved resource, e.g. '0.0' for a NO_UPFRONT
    /// offering
    fixed_price: ?f64 = null,

    /// User specified reservation name
    name: ?[]const u8 = null,

    /// Offering description, e.g. 'HD AVC output at 10-20 Mbps, 30 fps, and
    /// standard VQ in US West (Oregon)'
    offering_description: ?[]const u8 = null,

    /// Unique offering ID, e.g. '87654321'
    offering_id: ?[]const u8 = null,

    /// Offering type, e.g. 'NO_UPFRONT'
    offering_type: ?OfferingType = null,

    /// AWS region, e.g. 'us-west-2'
    region: ?[]const u8 = null,

    /// Renewal settings for the reservation
    renewal_settings: ?RenewalSettings = null,

    /// Unique reservation ID, e.g. '1234567'
    reservation_id: ?[]const u8 = null,

    /// Resource configuration details
    resource_specification: ?ReservationResourceSpecification = null,

    /// Reservation UTC start date and time in ISO-8601 format, e.g.
    /// '2018-03-01T00:00:00'
    start: ?[]const u8 = null,

    /// Current state of reservation, e.g. 'ACTIVE'
    state: ?ReservationState = null,

    /// A collection of key-value pairs
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Recurring usage charge for each reserved resource, e.g. '157.0'
    usage_price: ?f64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .count = "Count",
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .end = "End",
        .fixed_price = "FixedPrice",
        .name = "Name",
        .offering_description = "OfferingDescription",
        .offering_id = "OfferingId",
        .offering_type = "OfferingType",
        .region = "Region",
        .renewal_settings = "RenewalSettings",
        .reservation_id = "ReservationId",
        .resource_specification = "ResourceSpecification",
        .start = "Start",
        .state = "State",
        .tags = "Tags",
        .usage_price = "UsagePrice",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservationInput, options: Options) !DescribeReservationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/prod/reservations/");
    try path_buf.appendSlice(alloc, input.reservation_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeReservationOutput {
    var result: DescribeReservationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeReservationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
