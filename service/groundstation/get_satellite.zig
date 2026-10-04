const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EphemerisMetaData = @import("ephemeris_meta_data.zig").EphemerisMetaData;

pub const GetSatelliteInput = struct {
    /// UUID of a satellite.
    satellite_id: []const u8,

    pub const json_field_names = .{
        .satellite_id = "satelliteId",
    };
};

pub const GetSatelliteOutput = struct {
    /// The current ephemeris being used to compute the trajectory of the satellite.
    current_ephemeris: ?EphemerisMetaData = null,

    /// A list of ground stations to which the satellite is on-boarded.
    ground_stations: ?[]const []const u8 = null,

    /// NORAD satellite ID number.
    norad_satellite_id: ?i32 = null,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8 = null,

    /// UUID of a satellite.
    satellite_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_ephemeris = "currentEphemeris",
        .ground_stations = "groundStations",
        .norad_satellite_id = "noradSatelliteID",
        .satellite_arn = "satelliteArn",
        .satellite_id = "satelliteId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSatelliteInput, options: CallOptions) !GetSatelliteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSatelliteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/satellite/");
    try path_buf.appendSlice(allocator, input.satellite_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSatelliteOutput {
    var result: GetSatelliteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSatelliteOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
