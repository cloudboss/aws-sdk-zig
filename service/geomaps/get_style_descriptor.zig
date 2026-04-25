const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Buildings = @import("buildings.zig").Buildings;
const ColorScheme = @import("color_scheme.zig").ColorScheme;
const ContourDensity = @import("contour_density.zig").ContourDensity;
const MapStyle = @import("map_style.zig").MapStyle;
const Terrain = @import("terrain.zig").Terrain;
const Traffic = @import("traffic.zig").Traffic;
const TravelMode = @import("travel_mode.zig").TravelMode;

pub const GetStyleDescriptorInput = struct {
    /// Adjusts how building details are rendered on the map.
    ///
    /// The following building styles are currently supported:
    ///
    /// * `Buildings3D`: Displays buildings as three-dimensional extrusions on the
    ///   map.
    ///
    /// `Buildings3D` is valid only for the `Standard` and `Monochrome` map styles.
    buildings: ?Buildings = null,

    /// Sets the color tone for the map, such as dark and light.
    ///
    /// Example: `Light`
    ///
    /// Default value: `Light`
    ///
    /// Valid values for ColorScheme are case sensitive.
    color_scheme: ?ColorScheme = null,

    /// Displays the shape and steepness of terrain features using elevation lines.
    /// The density value controls how densely the available contour line
    /// information is rendered on the map. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// This parameter is valid for all map styles except `Satellite`.
    contour_density: ?ContourDensity = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Specifies the political view using ISO 3166-2 or ISO 3166-3 country code
    /// format. Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// The following political views are currently supported:
    ///
    /// * `ARG`: Argentina's view on the Southern Patagonian Ice Field and Tierra
    ///   Del Fuego, including the Falkland Islands, South Georgia, and South
    ///   Sandwich Islands
    /// * `EGY`: Egypt's view on Bir Tawil
    /// * `IND`: India's view on Gilgit-Baltistan
    /// * `KEN`: Kenya's view on the Ilemi Triangle
    /// * `MAR`: Morocco's view on Western Sahara
    /// * `RUS`: Russia's view on Crimea
    /// * `SDN`: Sudan's view on the Halaib Triangle
    /// * `SRB`: Serbia's view on Kosovo, Vukovar, and Sarengrad Islands
    /// * `SUR`: Suriname's view on the Courantyne Headwaters and Lawa Headwaters
    /// * `SYR`: Syria's view on the Golan Heights
    /// * `TUR`: Turkey's view on Cyprus and Northern Cyprus
    /// * `TZA`: Tanzania's view on Lake Malawi
    /// * `URY`: Uruguay's view on Rincon de Artigas
    /// * `VNM`: Vietnam's view on the Paracel Islands and Spratly Islands
    political_view: ?[]const u8 = null,

    /// Style specifies the desired map style. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `Standard` and `Monochrome` values.
    style: MapStyle,

    /// Adjusts how physical terrain details are rendered on the map. Not supported
    /// in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// The following terrain styles are currently supported:
    ///
    /// * `Hillshade`: Displays the physical terrain details through shading and
    ///   highlighting of elevation change and geographic features.
    /// * `Terrain3D`: Displays physical terrain details and elevations as a
    ///   three-dimensional model.
    ///
    /// `Hillshade` is valid only for the `Standard` and `Monochrome` map styles.
    terrain: ?Terrain = null,

    /// Displays real-time traffic information overlay on map, such as incident
    /// events and flow events. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// This parameter is valid for all map styles except `Satellite`.
    traffic: ?Traffic = null,

    /// Renders additional map information relevant to selected travel modes.
    /// Information for multiple travel modes can be displayed simultaneously,
    /// although this increases the overall information density rendered on the map.
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// This parameter is valid for all map styles except `Satellite`.
    travel_modes: ?[]const TravelMode = null,

    pub const json_field_names = .{
        .buildings = "Buildings",
        .color_scheme = "ColorScheme",
        .contour_density = "ContourDensity",
        .key = "Key",
        .political_view = "PoliticalView",
        .style = "Style",
        .terrain = "Terrain",
        .traffic = "Traffic",
        .travel_modes = "TravelModes",
    };
};

pub const GetStyleDescriptorOutput = struct {
    /// This Blob contains the body of the style descriptor which is in
    /// application/json format.
    blob: ?[]const u8 = null,

    /// Header that instructs caching configuration for the client.
    cache_control: ?[]const u8 = null,

    /// Header that represents the format of the response. The response returns the
    /// following as the HTTP body.
    content_type: ?[]const u8 = null,

    /// The style descriptor's Etag.
    e_tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
        .e_tag = "ETag",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStyleDescriptorInput, options: CallOptions) !GetStyleDescriptorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo-maps");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetStyleDescriptorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-maps", "Geo Maps", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/styles/");
    try path_buf.appendSlice(allocator, input.style);
    try path_buf.appendSlice(allocator, "/descriptor");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.buildings) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "buildings=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.color_scheme) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "color-scheme=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.contour_density) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "contour-density=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.political_view) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "political-view=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.terrain) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "terrain=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.traffic) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "traffic=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.travel_modes) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "travel-modes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStyleDescriptorOutput {
    var result: GetStyleDescriptorOutput = .{};
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

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
