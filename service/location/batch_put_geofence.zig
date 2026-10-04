const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchPutGeofenceRequestEntry = @import("batch_put_geofence_request_entry.zig").BatchPutGeofenceRequestEntry;
const BatchPutGeofenceError = @import("batch_put_geofence_error.zig").BatchPutGeofenceError;
const BatchPutGeofenceSuccess = @import("batch_put_geofence_success.zig").BatchPutGeofenceSuccess;

pub const BatchPutGeofenceInput = struct {
    /// The geofence collection storing the geofences.
    collection_name: []const u8,

    /// The batch of geofences to be stored in a geofence collection.
    entries: []const BatchPutGeofenceRequestEntry,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .entries = "Entries",
    };
};

pub const BatchPutGeofenceOutput = struct {
    /// Contains additional error details for each geofence that failed to be stored
    /// in a geofence collection.
    errors: ?[]const BatchPutGeofenceError = null,

    /// Contains each geofence that was successfully stored in a geofence
    /// collection.
    successes: ?[]const BatchPutGeofenceSuccess = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .successes = "Successes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutGeofenceInput, options: CallOptions) !BatchPutGeofenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutGeofenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    try path_buf.appendSlice(allocator, "/put-geofences");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutGeofenceOutput {
    var result: BatchPutGeofenceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchPutGeofenceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
