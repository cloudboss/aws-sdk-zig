const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const CreatePlaceIndexInput = struct {
    /// Specifies the geospatial data provider for the new place index.
    ///
    /// This field is case-sensitive. Enter the valid values as shown. For example,
    /// entering `HERE` returns an error.
    ///
    /// Valid values include:
    ///
    /// * `Esri` – For additional information about
    ///   [Esri](https://docs.aws.amazon.com/location/previous/developerguide/esri.html)'s coverage in your region of interest, see [Esri details on geocoding coverage](https://developers.arcgis.com/rest/geocode/api-reference/geocode-coverage.htm).
    /// * `Grab` – Grab provides place index functionality for Southeast Asia. For
    ///   additional information about
    ///   [GrabMaps](https://docs.aws.amazon.com/location/previous/developerguide/grab.html)' coverage, see [GrabMaps countries and areas covered](https://docs.aws.amazon.com/location/previous/developerguide/grab.html#grab-coverage-area).
    /// * `Here` – For additional information about [HERE
    ///   Technologies](https://docs.aws.amazon.com/location/previous/developerguide/HERE.html)' coverage in your region of interest, see [HERE details on goecoding coverage](https://developer.here.com/documentation/geocoder/dev_guide/topics/coverage-geocoder.html).
    ///
    /// If you specify HERE Technologies (`Here`) as the data provider, you may not
    /// [store
    /// results](https://docs.aws.amazon.com/location-places/latest/APIReference/API_DataSourceConfiguration.html) for locations in Japan. For more information, see the [Amazon Web Services service terms](http://aws.amazon.com/service-terms/) for Amazon Location Service.
    ///
    /// For additional information , see [Data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html) on the *Amazon Location Service developer guide*.
    data_source: []const u8,

    /// Specifies the data storage option requesting Places.
    data_source_configuration: ?DataSourceConfiguration = null,

    /// The optional description for the place index resource.
    description: ?[]const u8 = null,

    /// The name of the place index resource.
    ///
    /// Requirements:
    ///
    /// * Contain only alphanumeric characters (A–Z, a–z, 0–9), hyphens (-), periods
    ///   (.), and underscores (_).
    /// * Must be a unique place index resource name.
    /// * No spaces allowed. For example, `ExamplePlaceIndex`.
    index_name: []const u8,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// Applies one or more tags to the place index resource. A tag is a key-value
    /// pair that helps you manage, identify, search, and filter your resources.
    ///
    /// Format: `"key" : "value"`
    ///
    /// Restrictions:
    ///
    /// * Maximum 50 tags per resource.
    /// * Each tag key must be unique and must have exactly one associated value.
    /// * Maximum key length: 128 Unicode characters in UTF-8.
    /// * Maximum value length: 256 Unicode characters in UTF-8.
    /// * Can use alphanumeric characters (A–Z, a–z, 0–9), and the following
    ///   characters: + - = . _ : / @
    /// * Cannot use "aws:" as a prefix for a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .data_source_configuration = "DataSourceConfiguration",
        .description = "Description",
        .index_name = "IndexName",
        .pricing_plan = "PricingPlan",
        .tags = "Tags",
    };
};

pub const CreatePlaceIndexOutput = struct {
    /// The timestamp for when the place index resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The Amazon Resource Name (ARN) for the place index resource. Used to specify
    /// a resource across Amazon Web Services.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:place-index/ExamplePlaceIndex`
    index_arn: []const u8,

    /// The name for the place index resource.
    index_name: []const u8,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .index_arn = "IndexArn",
        .index_name = "IndexName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlaceIndexInput, options: CallOptions) !CreatePlaceIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlaceIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/places/v0/indexes";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSource\":");
    try aws.json.writeValue(@TypeOf(input.data_source), input.data_source, allocator, &body_buf);
    has_prev = true;
    if (input.data_source_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSourceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IndexName\":");
    try aws.json.writeValue(@TypeOf(input.index_name), input.index_name, allocator, &body_buf);
    has_prev = true;
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlaceIndexOutput {
    var result: CreatePlaceIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePlaceIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
