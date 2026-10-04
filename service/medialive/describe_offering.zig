const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferingDurationUnits = @import("offering_duration_units.zig").OfferingDurationUnits;
const OfferingType = @import("offering_type.zig").OfferingType;
const ReservationResourceSpecification = @import("reservation_resource_specification.zig").ReservationResourceSpecification;

pub const DescribeOfferingInput = struct {
    /// Unique offering ID, e.g. '87654321'
    offering_id: []const u8,

    pub const json_field_names = .{
        .offering_id = "OfferingId",
    };
};

pub const DescribeOfferingOutput = struct {
    /// Unique offering ARN, e.g.
    /// 'arn:aws:medialive:us-west-2:123456789012:offering:87654321'
    arn: ?[]const u8 = null,

    /// Currency code for usagePrice and fixedPrice in ISO-4217 format, e.g. 'USD'
    currency_code: ?[]const u8 = null,

    /// Lease duration, e.g. '12'
    duration: ?i32 = null,

    /// Units for duration, e.g. 'MONTHS'
    duration_units: ?OfferingDurationUnits = null,

    /// One-time charge for each reserved resource, e.g. '0.0' for a NO_UPFRONT
    /// offering
    fixed_price: ?f64 = null,

    /// Offering description, e.g. 'HD AVC output at 10-20 Mbps, 30 fps, and
    /// standard VQ in US West (Oregon)'
    offering_description: ?[]const u8 = null,

    /// Unique offering ID, e.g. '87654321'
    offering_id: ?[]const u8 = null,

    /// Offering type, e.g. 'NO_UPFRONT'
    offering_type: ?OfferingType = null,

    /// AWS region, e.g. 'us-west-2'
    region: ?[]const u8 = null,

    /// Resource configuration details
    resource_specification: ?ReservationResourceSpecification = null,

    /// Recurring usage charge for each reserved resource, e.g. '157.0'
    usage_price: ?f64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .fixed_price = "FixedPrice",
        .offering_description = "OfferingDescription",
        .offering_id = "OfferingId",
        .offering_type = "OfferingType",
        .region = "Region",
        .resource_specification = "ResourceSpecification",
        .usage_price = "UsagePrice",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOfferingInput, options: CallOptions) !DescribeOfferingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/offerings/");
    try path_buf.appendSlice(allocator, input.offering_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOfferingOutput {
    var result: DescribeOfferingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeOfferingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
