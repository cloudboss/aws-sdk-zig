const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Reservation = @import("reservation.zig").Reservation;

pub const DescribeReservationInput = struct {
    /// The Amazon Resource Name (ARN) of the offering.
    reservation_arn: []const u8,

    pub const json_field_names = .{
        .reservation_arn = "ReservationArn",
    };
};

pub const DescribeReservationOutput = struct {
    /// A pricing agreement for a discounted rate for a specific outbound bandwidth
    /// that your MediaConnect account will use each month over a specific time
    /// period. The discounted rate in the reservation applies to outbound bandwidth
    /// for all flows from your account until your account reaches the amount of
    /// bandwidth in your reservation. If you use more outbound bandwidth than the
    /// agreed upon amount in a single month, the overage is charged at the
    /// on-demand rate.
    reservation: ?Reservation = null,

    pub const json_field_names = .{
        .reservation = "Reservation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservationInput, options: CallOptions) !DescribeReservationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/reservations/");
    try path_buf.appendSlice(allocator, input.reservation_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservationOutput {
    const result: DescribeReservationOutput = try aws.json.parseJsonObject(
        DescribeReservationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
