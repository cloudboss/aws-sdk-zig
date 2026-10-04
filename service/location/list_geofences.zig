const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListGeofenceResponseEntry = @import("list_geofence_response_entry.zig").ListGeofenceResponseEntry;

pub const ListGeofencesInput = struct {
    /// The name of the geofence collection storing the list of geofences.
    collection_name: []const u8,

    /// An optional limit for the number of geofences returned in a single call.
    ///
    /// Default value: `100`
    max_results: ?i32 = null,

    /// The pagination token specifying which page of results to return in the
    /// response. If no token is provided, the default page is the first page.
    ///
    /// Default value: `null`
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListGeofencesOutput = struct {
    /// Contains a list of geofences stored in the geofence collection.
    entries: ?[]const ListGeofenceResponseEntry = null,

    /// A pagination token indicating there are additional pages available. You can
    /// use the token in a following request to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entries = "Entries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGeofencesInput, options: CallOptions) !ListGeofencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGeofencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    try path_buf.appendSlice(allocator, "/list-geofences");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGeofencesOutput {
    var result: ListGeofencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListGeofencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
