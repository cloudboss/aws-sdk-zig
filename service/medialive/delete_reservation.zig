const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferingDurationUnits = @import("offering_duration_units.zig").OfferingDurationUnits;
const OfferingType = @import("offering_type.zig").OfferingType;
const RenewalSettings = @import("renewal_settings.zig").RenewalSettings;
const ReservationResourceSpecification = @import("reservation_resource_specification.zig").ReservationResourceSpecification;
const ReservationState = @import("reservation_state.zig").ReservationState;

pub const DeleteReservationInput = struct {
    /// Unique reservation ID, e.g. '1234567'
    reservation_id: []const u8,

    pub const json_field_names = .{
        .reservation_id = "ReservationId",
    };
};

pub const DeleteReservationOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteReservationInput, options: CallOptions) !DeleteReservationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/reservations/");
    try path_buf.appendSlice(allocator, input.reservation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteReservationOutput {
    var result: DeleteReservationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteReservationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
