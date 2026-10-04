const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeofenceGeometry = @import("geofence_geometry.zig").GeofenceGeometry;

pub const PutGeofenceInput = struct {
    /// The geofence collection to store the geofence in.
    collection_name: []const u8,

    /// An identifier for the geofence. For example, `ExampleGeofence-1`.
    geofence_id: []const u8,

    /// Associates one of more properties with the geofence. A property is a
    /// key-value pair stored with the geofence and added to any geofence event
    /// triggered with that geofence.
    ///
    /// Format: `"key" : "value"`
    geofence_properties: ?[]const aws.map.StringMapEntry = null,

    /// Contains the details to specify the position of the geofence. Can be a
    /// circle, a polygon, or a multipolygon. `Polygon` and `MultiPolygon`
    /// geometries can be defined using their respective parameters, or encoded in
    /// Geobuf format using the `Geobuf` parameter. Including multiple geometry
    /// types in the same request will return a validation error.
    ///
    /// The geofence `Polygon` and `MultiPolygon` formats support a maximum of 1,000
    /// total vertices. The `Geobuf` format supports a maximum of 100,000 vertices.
    geometry: GeofenceGeometry,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .geofence_id = "GeofenceId",
        .geofence_properties = "GeofenceProperties",
        .geometry = "Geometry",
    };
};

pub const PutGeofenceOutput = struct {
    /// The timestamp for when the geofence was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The geofence identifier entered in the request.
    geofence_id: []const u8,

    /// The timestamp for when the geofence was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .geofence_id = "GeofenceId",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutGeofenceInput, options: CallOptions) !PutGeofenceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutGeofenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    try path_buf.appendSlice(allocator, "/geofences/");
    try path_buf.appendSlice(allocator, input.geofence_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.geofence_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GeofenceProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Geometry\":");
    try aws.json.writeValue(@TypeOf(input.geometry), input.geometry, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutGeofenceOutput {
    var result: PutGeofenceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutGeofenceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
