const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Buildings = @import("buildings.zig").Buildings;
const ColorScheme = @import("color_scheme.zig").ColorScheme;
const ContourDensity = @import("contour_density.zig").ContourDensity;
const PoiCategory = @import("poi_category.zig").PoiCategory;
const PoiDensity = @import("poi_density.zig").PoiDensity;
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

    /// Renders only the specified categories of points of interest. When you omit
    /// this parameter, the map renders all categories.
    ///
    /// The following categories are currently supported:
    ///
    /// * `FoodAndDrink`
    /// * `Entertainment`
    /// * `SightsAndMuseums`
    /// * `Transportation`
    /// * `Accommodations`
    /// * `LeisureAndOutdoor`
    /// * `Shopping`
    /// * `BusinessAndServices`
    /// * `FacilitiesAndBuildings`
    ///
    /// Specify each category as a separate `poi-categories` query parameter.
    /// Duplicate values are rejected.
    ///
    /// This parameter has no effect when `poi-density` is set to `Off`, which hides
    /// all points of interest regardless of category.
    ///
    /// This parameter is valid only for the `Standard` and `Hybrid` map styles. In
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, this parameter is valid only for the `Standard` map style.
    poi_categories: ?[]const PoiCategory = null,

    /// Controls how densely points of interest are rendered on the map. The density
    /// value controls the zoom level at which each category of points of interest
    /// appears, and how quickly less prominent points of interest are revealed as
    /// you zoom in. Denser values display more points of interest at lower zoom
    /// levels.
    ///
    /// Use `Off` to hide all points of interest. When you omit this parameter, the
    /// map renders at `Default` density.
    ///
    /// The difference between density values is most noticeable at mid-range zoom
    /// levels. At high zoom levels, all density values converge on displaying every
    /// available point of interest.
    ///
    /// This parameter is valid only for the `Standard` and `Hybrid` map styles. In
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, this parameter is valid only for the `Standard` map style.
    poi_density: ?PoiDensity = null,

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
        .poi_categories = "PoiCategories",
        .poi_density = "PoiDensity",
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStyleDescriptorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-maps", "Geo Maps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/styles/");
    try path_buf.appendSlice(allocator, input.style);
    try path_buf.appendSlice(allocator, "/descriptor");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
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
    if (input.poi_categories) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "poi-categories=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.poi_density) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "poi-density=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStyleDescriptorOutput {
    var result: GetStyleDescriptorOutput = .{};
    errdefer {
        if (result.cache_control) |value| allocator.free(value);
        if (result.content_type) |value| allocator.free(value);
        if (result.e_tag) |value| allocator.free(value);
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

    return result;
}
