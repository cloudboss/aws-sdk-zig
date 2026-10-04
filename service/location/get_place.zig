const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Place = @import("place.zig").Place;

pub const GetPlaceInput = struct {
    /// The name of the place index resource that you want to use for the search.
    index_name: []const u8,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// The preferred language used to return results. The value must be a valid
    /// [BCP 47](https://tools.ietf.org/search/bcp47) language tag, for example,
    /// `en` for English.
    ///
    /// This setting affects the languages used in the results, but not the results
    /// themselves. If no language is specified, or not supported for a particular
    /// result, the partner automatically chooses a language for the result.
    ///
    /// For an example, we'll use the Greek language. You search for a location
    /// around Athens, Greece, with the `language` parameter set to `en`. The `city`
    /// in the results will most likely be returned as `Athens`.
    ///
    /// If you set the `language` parameter to `el`, for Greek, then the `city` in
    /// the results will more likely be returned as `Αθήνα`.
    ///
    /// If the data provider does not have a value for Greek, the result will be in
    /// a language that the provider does support.
    language: ?[]const u8 = null,

    /// The identifier of the place to find.
    place_id: []const u8,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .key = "Key",
        .language = "Language",
        .place_id = "PlaceId",
    };
};

pub const GetPlaceOutput = struct {
    /// Details about the result, such as its address and position.
    place: ?Place = null,

    pub const json_field_names = .{
        .place = "Place",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlaceInput, options: CallOptions) !GetPlaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/places/v0/indexes/");
    try path_buf.appendSlice(allocator, input.index_name);
    try path_buf.appendSlice(allocator, "/places/");
    try path_buf.appendSlice(allocator, input.place_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.language) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "language=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlaceOutput {
    var result: GetPlaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPlaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
