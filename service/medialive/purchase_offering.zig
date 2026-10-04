const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RenewalSettings = @import("renewal_settings.zig").RenewalSettings;
const Reservation = @import("reservation.zig").Reservation;

pub const PurchaseOfferingInput = struct {
    /// Number of resources
    count: i32,

    /// Name for the new reservation
    name: ?[]const u8 = null,

    /// Offering to purchase, e.g. '87654321'
    offering_id: []const u8,

    /// Renewal settings for the reservation
    renewal_settings: ?RenewalSettings = null,

    /// Unique request ID to be specified. This is needed to prevent retries from
    /// creating multiple resources.
    request_id: ?[]const u8 = null,

    /// Requested reservation start time (UTC) in ISO-8601 format. The specified
    /// time must be between the first day of the current month and one year from
    /// now. If no value is given, the default is now.
    start: ?[]const u8 = null,

    /// A collection of key-value pairs
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .count = "Count",
        .name = "Name",
        .offering_id = "OfferingId",
        .renewal_settings = "RenewalSettings",
        .request_id = "RequestId",
        .start = "Start",
        .tags = "Tags",
    };
};

pub const PurchaseOfferingOutput = struct {
    reservation: ?Reservation = null,

    pub const json_field_names = .{
        .reservation = "Reservation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseOfferingInput, options: CallOptions) !PurchaseOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/offerings/");
    try path_buf.appendSlice(allocator, input.offering_id);
    try path_buf.appendSlice(allocator, "/purchase");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Count\":");
    try aws.json.writeValue(@TypeOf(input.count), input.count, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.renewal_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RenewalSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Start\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseOfferingOutput {
    const result: PurchaseOfferingOutput = try aws.json.parseJsonObject(
        PurchaseOfferingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
