const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Reservation = @import("reservation.zig").Reservation;

pub const ListReservationsInput = struct {
    /// The maximum number of results to return per API request.
    ///
    /// For example, you submit a `ListReservations` request with `MaxResults` set
    /// at 5. Although 20 items match your request, the service returns no more than
    /// the first 5 items. (The service also returns a NextToken value that you can
    /// use to fetch the next batch of results.)
    ///
    /// The service might return fewer results than the `MaxResults` value. If
    /// `MaxResults` is not included in the request, the service defaults to
    /// pagination with a maximum of 10 results per page.
    max_results: ?i32 = null,

    /// The token that identifies the batch of results that you want to see.
    ///
    /// For example, you submit a `ListReservations` request with `MaxResults` set
    /// at 5. The service returns the first batch of results (up to 5) and a
    /// `NextToken` value. To see the next batch of results, you can submit the
    /// `ListOfferings` request a second time and specify the `NextToken` value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListReservationsOutput = struct {
    /// The token that identifies the batch of results that you want to see.
    ///
    /// For example, you submit a `ListReservations` request with `MaxResults` set
    /// at 5. The service returns the first batch of results (up to 5) and a
    /// `NextToken` value. To see the next batch of results, you can submit the
    /// `ListReservations` request a second time and specify the `NextToken` value.
    next_token: ?[]const u8 = null,

    /// A list of all reservations that have been purchased by this account in the
    /// current Amazon Web Services Region.
    reservations: ?[]const Reservation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reservations = "Reservations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReservationsInput, options: CallOptions) !ListReservationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReservationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/reservations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReservationsOutput {
    const result: ListReservationsOutput = try aws.json.parseJsonObject(
        ListReservationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
