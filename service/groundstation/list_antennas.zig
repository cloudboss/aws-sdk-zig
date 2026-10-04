const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AntennaListItem = @import("antenna_list_item.zig").AntennaListItem;

pub const ListAntennasInput = struct {
    /// ID of a ground station.
    ground_station_id: []const u8,

    /// Maximum number of antennas returned.
    max_results: ?i32 = null,

    /// Next token returned in the request of a previous `ListAntennas` call. Used
    /// to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ground_station_id = "groundStationId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAntennasOutput = struct {
    /// List of antennas.
    antenna_list: ?[]const AntennaListItem = null,

    /// Next token to be used in a subsequent `ListAntennas` call to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .antenna_list = "antennaList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAntennasInput, options: CallOptions) !ListAntennasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAntennasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/groundstation/");
    try path_buf.appendSlice(allocator, input.ground_station_id);
    try path_buf.appendSlice(allocator, "/antenna");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAntennasOutput {
    var result: ListAntennasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAntennasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
