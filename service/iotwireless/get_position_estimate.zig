const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedConfiguration = @import("advanced_configuration.zig").AdvancedConfiguration;
const CellTowers = @import("cell_towers.zig").CellTowers;
const Gnss = @import("gnss.zig").Gnss;
const GnssMultiFrame = @import("gnss_multi_frame.zig").GnssMultiFrame;
const Ip = @import("ip.zig").Ip;
const WiFiAccessPoint = @import("wi_fi_access_point.zig").WiFiAccessPoint;

pub const GetPositionEstimateInput = struct {
    /// Optional configuration for customizing position measurement data.
    advanced_configuration: ?AdvancedConfiguration = null,

    /// Retrieves an estimated device position by resolving measurement data from
    /// cellular
    /// radio towers. The position is resolved using HERE's cellular-based solver.
    cell_towers: ?CellTowers = null,

    /// Retrieves an estimated device position by resolving the global navigation
    /// satellite
    /// system (GNSS) scan data. The position is resolved using the GNSS solver
    /// powered by LoRa
    /// Cloud. This field is mutually exclusive with the GnssMultiFrame field.
    gnss: ?Gnss = null,

    /// Retrieves an estimated device position by resolving multiple global
    /// navigation
    /// satellite system (GNSS) scan captures. The position is resolved using the
    /// multi-frame
    /// GNSS solver powered by LoRa Cloud. This field is mutually exclusive with the
    /// Gnss
    /// field.
    gnss_multi_frame: ?GnssMultiFrame = null,

    /// Retrieves an estimated device position by resolving the IP address
    /// information from
    /// the device. The position is resolved using MaxMind's IP-based solver.
    ip: ?Ip = null,

    /// Optional information that specifies the time when the position information
    /// will be
    /// resolved. It uses the Unix timestamp format. If not specified, the time at
    /// which the
    /// request was received will be used.
    timestamp: ?i64 = null,

    /// Retrieves an estimated device position by resolving WLAN measurement data.
    /// The
    /// position is resolved using HERE's Wi-Fi based solver.
    wi_fi_access_points: ?[]const WiFiAccessPoint = null,

    pub const json_field_names = .{
        .advanced_configuration = "AdvancedConfiguration",
        .cell_towers = "CellTowers",
        .gnss = "Gnss",
        .gnss_multi_frame = "GnssMultiFrame",
        .ip = "Ip",
        .timestamp = "Timestamp",
        .wi_fi_access_points = "WiFiAccessPoints",
    };
};

pub const GetPositionEstimateOutput = struct {
    /// The position information of the resource, displayed as a JSON payload. The
    /// payload is
    /// of type blob and uses the [GeoJSON](https://geojson.org/) format,
    /// which a format that's used to encode geographic data structures. A sample
    /// payload
    /// contains the timestamp information, the WGS84 coordinates of the location,
    /// and the
    /// accuracy and confidence level. For more information and examples, see
    /// [Resolve device location
    /// (console)](https://docs.aws.amazon.com/iot/latest/developerguide/location-resolve-console.html).
    geo_json_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .geo_json_payload = "GeoJsonPayload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPositionEstimateInput, options: CallOptions) !GetPositionEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPositionEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/position-estimate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.advanced_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdvancedConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cell_towers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CellTowers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gnss) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Gnss\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gnss_multi_frame) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GnssMultiFrame\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Ip\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Timestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wi_fi_access_points) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WiFiAccessPoints\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPositionEstimateOutput {
    var result: GetPositionEstimateOutput = .{};
    errdefer {
        if (result.geo_json_payload) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.geo_json_payload = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
