const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ColorScheme = @import("color_scheme.zig").ColorScheme;
const LabelSize = @import("label_size.zig").LabelSize;
const MapFeatureMode = @import("map_feature_mode.zig").MapFeatureMode;
const ScaleBarUnit = @import("scale_bar_unit.zig").ScaleBarUnit;
const StaticMapStyle = @import("static_map_style.zig").StaticMapStyle;

pub const GetStaticMapInput = struct {
    /// Takes in two or more pair of coordinates in World Geodetic System (WGS 84)
    /// format: [longitude, latitude], with each coordinate separated by a comma.
    /// The API will generate an image to encompass all of the provided coordinates.
    ///
    /// Cannot be used with `Zoom` and or `Radius`
    ///
    /// Example: 97.170451,78.039098,99.045536,27.176178
    bounded_positions: ?[]const u8 = null,

    /// Takes in two pairs of coordinates in World Geodetic System (WGS 84) format:
    /// [longitude, latitude], denoting south-westerly and north-easterly edges of
    /// the image. The underlying area becomes the view of the image.
    ///
    /// Example: -123.17075,49.26959,-123.08125,49.31429
    bounding_box: ?[]const u8 = null,

    /// Takes in a pair of coordinates in World Geodetic System (WGS 84) format:
    /// [longitude, latitude], which becomes the center point of the image. This
    /// parameter requires that either zoom or radius is set.
    ///
    /// Cannot be used with `Zoom` and or `Radius`
    ///
    /// Example: 49.295,-123.108
    center: ?[]const u8 = null,

    /// Sets color tone for map, such as dark and light for specific map styles. It
    /// only applies to vector map styles, such as Standard.
    ///
    /// Example: `Light`
    ///
    /// Default value: `Light`
    ///
    /// Valid values for `ColorScheme` are case sensitive.
    color_scheme: ?ColorScheme = null,

    /// Takes in a string to draw geometries on the image. The input is a comma
    /// separated format as follows format: `[Lon, Lat]`
    ///
    /// Example:
    /// `line:-122.407653,37.798557,-122.413291,37.802443;color=%23DD0000;width=7;outline-color=#00DD00;outline-width=5yd|point:-122.40572,37.80004;label=Fog Hill Market;size=large;text-color=%23DD0000;color=#EE4B2B`
    ///
    /// Currently it supports the following geometry types: point, line and polygon.
    /// It does not support multiPoint , multiLine and multiPolgyon.
    compact_overlay: ?[]const u8 = null,

    /// It is a flag that takes in true or false. It prevents the labels that are on
    /// the edge of the image from being cut or obscured.
    crop_labels: ?bool = null,

    /// The map scaling parameter to size the image, icons, and labels. It follows
    /// the pattern of `^map(@2x)?$`.
    ///
    /// Example: `map, map@2x`
    file_name: []const u8,

    /// Takes in a string to draw geometries on the image. The input is a valid
    /// GeoJSON collection object.
    ///
    /// Example: `{"type":"FeatureCollection","features":
    /// [{"type":"Feature","geometry":{"type":"MultiPoint","coordinates":
    /// [[-90.076345,51.504107],[-0.074451,51.506892]]},"properties":
    /// {"color":"#00DD00"}}]}`
    geo_json_overlay: ?[]const u8 = null,

    /// Specifies the height of the map image.
    height: i32,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Overrides the label size auto-calculated by `FileName`. Takes in one of the
    /// values - `Small` or `Large`.
    label_size: ?LabelSize = null,

    /// Specifies the language on the map labels using the BCP 47 language tag,
    /// limited to ISO 639-1 two-letter language codes. If the specified language
    /// data isn't available for the map image, the labels will default to the
    /// regional primary language.
    ///
    /// Supported codes:
    ///
    /// * `ar`
    /// * `as`
    /// * `az`
    /// * `be`
    /// * `bg`
    /// * `bn`
    /// * `bs`
    /// * `ca`
    /// * `cs`
    /// * `cy`
    /// * `da`
    /// * `de`
    /// * `el`
    /// * `en`
    /// * `es`
    /// * `et`
    /// * `eu`
    /// * `fi`
    /// * `fo`
    /// * `fr`
    /// * `ga`
    /// * `gl`
    /// * `gn`
    /// * `gu`
    /// * `he`
    /// * `hi`
    /// * `hr`
    /// * `hu`
    /// * `hy`
    /// * `id`
    /// * `is`
    /// * `it`
    /// * `ja`
    /// * `ka`
    /// * `kk`
    /// * `km`
    /// * `kn`
    /// * `ko`
    /// * `ky`
    /// * `lt`
    /// * `lv`
    /// * `mk`
    /// * `ml`
    /// * `mr`
    /// * `ms`
    /// * `mt`
    /// * `my`
    /// * `nl`
    /// * `no`
    /// * `or`
    /// * `pa`
    /// * `pl`
    /// * `pt`
    /// * `ro`
    /// * `ru`
    /// * `sk`
    /// * `sl`
    /// * `sq`
    /// * `sr`
    /// * `sv`
    /// * `ta`
    /// * `te`
    /// * `th`
    /// * `tr`
    /// * `uk`
    /// * `uz`
    /// * `vi`
    /// * `zh`
    language: ?[]const u8 = null,

    /// Applies additional space (in pixels) around overlay feature to prevent them
    /// from being cut or obscured.
    ///
    /// Value for max and min is determined by:
    ///
    /// Min: `1`
    ///
    /// Max: `min(height, width)/4`
    ///
    /// Example: `100`
    padding: ?i32 = null,

    /// Determines if the result image will display icons representing points of
    /// interest on the map.
    points_of_interests: ?MapFeatureMode = null,

    /// Specifies the political view, using ISO 3166-2 or ISO 3166-3 country code
    /// format.
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

    /// Used with center parameter, it specifies the zoom of the image where you can
    /// control it on a granular level. Takes in any value `>= 1`.
    ///
    /// Example: `1500`
    ///
    /// Cannot be used with `Zoom`.
    ///
    /// **Unit**: `Meters`
    radius: ?i64 = null,

    /// Displays a scale on the bottom right of the map image with the unit
    /// specified in the input.
    ///
    /// Example: `KilometersMiles, Miles, Kilometers, MilesKilometers`
    scale_bar_unit: ?ScaleBarUnit = null,

    /// `Style` specifies the desired map style.
    style: ?StaticMapStyle = null,

    /// Specifies the width of the map image.
    width: i32,

    /// Specifies the zoom level of the map image.
    ///
    /// Cannot be used with `Radius`.
    zoom: ?f32 = null,

    pub const json_field_names = .{
        .bounded_positions = "BoundedPositions",
        .bounding_box = "BoundingBox",
        .center = "Center",
        .color_scheme = "ColorScheme",
        .compact_overlay = "CompactOverlay",
        .crop_labels = "CropLabels",
        .file_name = "FileName",
        .geo_json_overlay = "GeoJsonOverlay",
        .height = "Height",
        .key = "Key",
        .label_size = "LabelSize",
        .language = "Language",
        .padding = "Padding",
        .points_of_interests = "PointsOfInterests",
        .political_view = "PoliticalView",
        .radius = "Radius",
        .scale_bar_unit = "ScaleBarUnit",
        .style = "Style",
        .width = "Width",
        .zoom = "Zoom",
    };
};

pub const GetStaticMapOutput = struct {
    /// The blob represents a map image as a `jpeg` for the `GetStaticMap` API.
    blob: ?[]const u8 = null,

    /// Header that instructs caching configuration for the client.
    cache_control: ?[]const u8 = null,

    /// Header that represents the format of the response. The response returns the
    /// following as the HTTP body.
    content_type: ?[]const u8 = null,

    /// The static map's Etag.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStaticMapInput, options: CallOptions) !GetStaticMapOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geomaps");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStaticMapInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geomaps", "Geo Maps", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/static/");
    try path_buf.appendSlice(allocator, input.file_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.bounded_positions) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "bounded-positions=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.bounding_box) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "bounding-box=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.center) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "center=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.color_scheme) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "color-scheme=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.compact_overlay) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "compact-overlay=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.crop_labels) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "crop-labels=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.geo_json_overlay) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "geojson-overlay=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "height=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.height}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.label_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "label-size=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.language) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "lang=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.padding) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "padding=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.points_of_interests) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pois=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.political_view) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "political-view=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.radius) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "radius=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.scale_bar_unit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "scale-unit=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.style) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "style=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "width=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.width}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.zoom) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "zoom=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStaticMapOutput {
    var result: GetStaticMapOutput = .{};
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
