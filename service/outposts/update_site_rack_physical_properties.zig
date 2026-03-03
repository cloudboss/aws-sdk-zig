const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FiberOpticCableType = @import("fiber_optic_cable_type.zig").FiberOpticCableType;
const MaximumSupportedWeightLbs = @import("maximum_supported_weight_lbs.zig").MaximumSupportedWeightLbs;
const OpticalStandard = @import("optical_standard.zig").OpticalStandard;
const PowerConnector = @import("power_connector.zig").PowerConnector;
const PowerDrawKva = @import("power_draw_kva.zig").PowerDrawKva;
const PowerFeedDrop = @import("power_feed_drop.zig").PowerFeedDrop;
const PowerPhase = @import("power_phase.zig").PowerPhase;
const UplinkCount = @import("uplink_count.zig").UplinkCount;
const UplinkGbps = @import("uplink_gbps.zig").UplinkGbps;
const Site = @import("site.zig").Site;

pub const UpdateSiteRackPhysicalPropertiesInput = struct {
    /// The type of fiber that you will use to attach the Outpost to your network.
    fiber_optic_cable_type: ?FiberOpticCableType = null,

    /// The maximum rack weight that this site can support. `NO_LIMIT` is over
    /// 2000lbs.
    maximum_supported_weight_lbs: ?MaximumSupportedWeightLbs = null,

    /// The type of optical standard that you will use to attach the Outpost to your
    /// network. This
    /// field is dependent on uplink speed, fiber type, and distance to the upstream
    /// device.
    /// For more information
    /// about networking requirements for racks, see
    /// [Network](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-requirements.html#facility-networking)
    /// in the Amazon Web Services Outposts User Guide.
    ///
    /// * `OPTIC_10GBASE_SR`: 10GBASE-SR
    ///
    /// * `OPTIC_10GBASE_IR`: 10GBASE-IR
    ///
    /// * `OPTIC_10GBASE_LR`: 10GBASE-LR
    ///
    /// * `OPTIC_40GBASE_SR`: 40GBASE-SR
    ///
    /// * `OPTIC_40GBASE_ESR`: 40GBASE-ESR
    ///
    /// * `OPTIC_40GBASE_IR4_LR4L`: 40GBASE-IR (LR4L)
    ///
    /// * `OPTIC_40GBASE_LR4`: 40GBASE-LR4
    ///
    /// * `OPTIC_100GBASE_SR4`: 100GBASE-SR4
    ///
    /// * `OPTIC_100GBASE_CWDM4`: 100GBASE-CWDM4
    ///
    /// * `OPTIC_100GBASE_LR4`: 100GBASE-LR4
    ///
    /// * `OPTIC_100G_PSM4_MSA`: 100G PSM4 MSA
    ///
    /// * `OPTIC_1000BASE_LX`: 1000Base-LX
    ///
    /// * `OPTIC_1000BASE_SX` : 1000Base-SX
    optical_standard: ?OpticalStandard = null,

    /// The power connector that Amazon Web Services should plan to provide for
    /// connections to the hardware.
    /// Note the correlation between `PowerPhase` and `PowerConnector`.
    ///
    /// * Single-phase AC feed
    ///
    /// * **L6-30P** – (common in US); 30A; single phase
    ///
    /// * **IEC309 (blue)** – P+N+E, 6hr; 32 A; single
    /// phase
    ///
    /// * Three-phase AC feed
    ///
    /// * **AH530P7W (red)** – 3P+N+E, 7hr; 30A; three
    /// phase
    ///
    /// * **AH532P6W (red)** – 3P+N+E, 6hr; 32A; three
    /// phase
    ///
    /// * **CS8365C** – (common in US); 3P+E, 50A; three
    /// phase
    power_connector: ?PowerConnector = null,

    /// The power draw, in kVA, available at the hardware placement position for the
    /// rack.
    power_draw_kva: ?PowerDrawKva = null,

    /// Indicates whether the power feed comes above or below the rack.
    power_feed_drop: ?PowerFeedDrop = null,

    /// The power option that you can provide for hardware.
    ///
    /// * Single-phase AC feed: 200 V to 277 V, 50 Hz or 60 Hz
    ///
    /// * Three-phase AC feed: 346 V to 480 V, 50 Hz or 60 Hz
    power_phase: ?PowerPhase = null,

    /// The ID or the Amazon Resource Name (ARN) of the site.
    site_id: []const u8,

    /// Racks come with two Outpost network devices. Depending on the supported
    /// uplink speed at
    /// the site, the Outpost network devices provide a variable number of uplinks.
    /// Specify the number
    /// of uplinks for each Outpost network device that you intend to use to connect
    /// the rack to your
    /// network. Note the correlation between `UplinkGbps` and `UplinkCount`.
    ///
    /// * 1Gbps - Uplinks available: 1, 2, 4, 6, 8
    ///
    /// * 10Gbps - Uplinks available: 1, 2, 4, 8, 12, 16
    ///
    /// * 40 and 100 Gbps- Uplinks available: 1, 2, 4
    uplink_count: ?UplinkCount = null,

    /// The uplink speed the rack should support for the connection to the Region.
    uplink_gbps: ?UplinkGbps = null,

    pub const json_field_names = .{
        .fiber_optic_cable_type = "FiberOpticCableType",
        .maximum_supported_weight_lbs = "MaximumSupportedWeightLbs",
        .optical_standard = "OpticalStandard",
        .power_connector = "PowerConnector",
        .power_draw_kva = "PowerDrawKva",
        .power_feed_drop = "PowerFeedDrop",
        .power_phase = "PowerPhase",
        .site_id = "SiteId",
        .uplink_count = "UplinkCount",
        .uplink_gbps = "UplinkGbps",
    };
};

pub const UpdateSiteRackPhysicalPropertiesOutput = struct {
    site: ?Site = null,

    pub const json_field_names = .{
        .site = "Site",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSiteRackPhysicalPropertiesInput, options: CallOptions) !UpdateSiteRackPhysicalPropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "outposts");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSiteRackPhysicalPropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/sites/");
    try path_buf.appendSlice(allocator, input.site_id);
    try path_buf.appendSlice(allocator, "/rackPhysicalProperties");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.fiber_optic_cable_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FiberOpticCableType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_supported_weight_lbs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumSupportedWeightLbs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optical_standard) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OpticalStandard\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.power_connector) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PowerConnector\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.power_draw_kva) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PowerDrawKva\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.power_feed_drop) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PowerFeedDrop\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.power_phase) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PowerPhase\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.uplink_count) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UplinkCount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.uplink_gbps) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UplinkGbps\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSiteRackPhysicalPropertiesOutput {
    var result: UpdateSiteRackPhysicalPropertiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSiteRackPhysicalPropertiesOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
