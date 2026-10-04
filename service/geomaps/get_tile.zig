const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TileAdditionalFeature = @import("tile_additional_feature.zig").TileAdditionalFeature;

pub const GetTileInput = struct {
    /// A list of optional additional parameters such as map styles that can be
    /// requested for each result. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    additional_features: ?[]const TileAdditionalFeature = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Specifies the desired tile set. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `vector.basemap` value.
    ///
    /// Valid Values: `raster.satellite | vector.basemap | vector.traffic |
    /// raster.dem`
    tileset: []const u8,

    /// The X axis value for the map tile.
    x: []const u8,

    /// The Y axis value for the map tile.
    y: []const u8,

    /// The zoom value for the map tile.
    z: []const u8,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .key = "Key",
        .tileset = "Tileset",
        .x = "X",
        .y = "Y",
        .z = "Z",
    };
};

pub const GetTileOutput = struct {
    /// The blob represents a vector tile in `mvt` or a raster tile in an image
    /// format.
    blob: ?[]const u8 = null,

    /// Header that instructs caching configuration for the client.
    cache_control: ?[]const u8 = null,

    /// Header that represents the format of the response. The response returns the
    /// following as the HTTP body.
    content_type: ?[]const u8 = null,

    /// The pricing bucket for which the request is charged at.
    e_tag: ?[]const u8 = null,

    /// The pricing bucket for which the request is charged at.
    pricing_bucket: []const u8,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
        .e_tag = "ETag",
        .pricing_bucket = "PricingBucket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTileInput, options: CallOptions) !GetTileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo-maps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-maps", "Geo Maps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/tiles/");
    try path_buf.appendSlice(allocator, input.tileset);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.z);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.x);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.y);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.additional_features) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "additional-features=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTileOutput {
    var result: GetTileOutput = .{
        .pricing_bucket = "",
    };
    errdefer {
        if (result.cache_control) |value| allocator.free(value);
        if (result.content_type) |value| allocator.free(value);
        if (result.e_tag) |value| allocator.free(value);
        allocator.free(result.pricing_bucket);
        if (result.blob) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.blob = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
