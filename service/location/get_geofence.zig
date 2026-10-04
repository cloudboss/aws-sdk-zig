const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeofenceGeometry = @import("geofence_geometry.zig").GeofenceGeometry;

pub const GetGeofenceInput = struct {
    /// The geofence collection storing the target geofence.
    collection_name: []const u8,

    /// The geofence you're retrieving details for.
    geofence_id: []const u8,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .geofence_id = "GeofenceId",
    };
};

pub const GetGeofenceOutput = struct {
    /// The timestamp for when the geofence collection was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The geofence identifier.
    geofence_id: []const u8,

    /// User defined properties of the geofence. A property is a key-value pair
    /// stored with the geofence and added to any geofence event triggered with that
    /// geofence.
    ///
    /// Format: `"key" : "value"`
    geofence_properties: ?[]const aws.map.StringMapEntry = null,

    /// Contains the geofence geometry details describing the position of the
    /// geofence. Can be a circle, a polygon, or a multipolygon.
    geometry: ?GeofenceGeometry = null,

    /// Identifies the state of the geofence. A geofence will hold one of the
    /// following states:
    ///
    /// * `ACTIVE` — The geofence has been indexed by the system.
    /// * `PENDING` — The geofence is being processed by the system.
    /// * `FAILED` — The geofence failed to be indexed by the system.
    /// * `DELETED` — The geofence has been deleted from the system index.
    /// * `DELETING` — The geofence is being deleted from the system index.
    status: []const u8,

    /// The timestamp for when the geofence collection was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .geofence_id = "GeofenceId",
        .geofence_properties = "GeofenceProperties",
        .geometry = "Geometry",
        .status = "Status",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGeofenceInput, options: CallOptions) !GetGeofenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGeofenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    try path_buf.appendSlice(allocator, "/geofences/");
    try path_buf.appendSlice(allocator, input.geofence_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGeofenceOutput {
    const result: GetGeofenceOutput = try aws.json.parseJsonObject(
        GetGeofenceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
