const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PurchaseReservedElasticsearchInstanceOfferingInput = struct {
    /// The number of Elasticsearch instances to reserve.
    instance_count: ?i32 = null,

    /// A customer-specified identifier to track this reservation.
    reservation_name: []const u8,

    /// The ID of the reserved Elasticsearch instance offering to purchase.
    reserved_elasticsearch_instance_offering_id: []const u8,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .reservation_name = "ReservationName",
        .reserved_elasticsearch_instance_offering_id = "ReservedElasticsearchInstanceOfferingId",
    };
};

pub const PurchaseReservedElasticsearchInstanceOfferingOutput = struct {
    /// The customer-specified identifier used to track this reservation.
    reservation_name: ?[]const u8 = null,

    /// Details of the reserved Elasticsearch instance which was purchased.
    reserved_elasticsearch_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .reservation_name = "ReservationName",
        .reserved_elasticsearch_instance_id = "ReservedElasticsearchInstanceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedElasticsearchInstanceOfferingInput, options: CallOptions) !PurchaseReservedElasticsearchInstanceOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedElasticsearchInstanceOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/purchaseReservedInstanceOffering";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.instance_count) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceCount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReservationName\":");
    try aws.json.writeValue(@TypeOf(input.reservation_name), input.reservation_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReservedElasticsearchInstanceOfferingId\":");
    try aws.json.writeValue(@TypeOf(input.reserved_elasticsearch_instance_offering_id), input.reserved_elasticsearch_instance_offering_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedElasticsearchInstanceOfferingOutput {
    var result: PurchaseReservedElasticsearchInstanceOfferingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PurchaseReservedElasticsearchInstanceOfferingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
