const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Quality = @import("quality.zig").Quality;
const InterpolatedAssetPropertyValue = @import("interpolated_asset_property_value.zig").InterpolatedAssetPropertyValue;

pub const GetInterpolatedAssetPropertyValuesInput = struct {
    /// The ID of the asset, in UUID format.
    asset_id: ?[]const u8 = null,

    /// The inclusive end of the range from which to interpolate data, expressed in
    /// seconds in
    /// Unix epoch time.
    end_time_in_seconds: i64,

    /// The nanosecond offset converted from `endTimeInSeconds`.
    end_time_offset_in_nanos: ?i32 = null,

    /// The time interval in seconds over which to interpolate data. Each interval
    /// starts when the
    /// previous one ends.
    interval_in_seconds: i64,

    /// The query interval for the window, in seconds. IoT SiteWise computes each
    /// interpolated value by
    /// using data points from the timestamp of each interval, minus the window to
    /// the timestamp of
    /// each interval plus the window. If not specified, the window ranges between
    /// the start time
    /// minus the interval and the end time plus the interval.
    ///
    /// * If you specify a value for the `intervalWindowInSeconds` parameter, the
    /// value for the `type` parameter must be
    /// `LINEAR_INTERPOLATION`.
    ///
    /// * If a data point isn't found during the specified query window, IoT
    ///   SiteWise won't return an
    /// interpolated value for the interval. This indicates that there's a gap in
    /// the ingested
    /// data points.
    ///
    /// For example, you can get the interpolated temperature values for a wind
    /// turbine every 24
    /// hours over a duration of 7 days. If the interpolation starts on July 1,
    /// 2021, at 9 AM with a
    /// window of 2 hours, IoT SiteWise uses the data points from 7 AM (9 AM minus 2
    /// hours) to 11 AM (9 AM
    /// plus 2 hours) on July 2, 2021 to compute the first interpolated value. Next,
    /// IoT SiteWise uses the
    /// data points from 7 AM (9 AM minus 2 hours) to 11 AM (9 AM plus 2 hours) on
    /// July 3, 2021 to
    /// compute the second interpolated value, and so on.
    interval_window_in_seconds: ?i64 = null,

    /// The maximum number of results to return for each paginated request. If not
    /// specified, the default value is 10.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    property_alias: ?[]const u8 = null,

    /// The ID of the asset property, in UUID format.
    property_id: ?[]const u8 = null,

    /// The quality of the asset property value. You can use this parameter as a
    /// filter to choose
    /// only the asset property values that have a specific quality.
    quality: Quality,

    /// The exclusive start of the range from which to interpolate data, expressed
    /// in seconds in
    /// Unix epoch time.
    start_time_in_seconds: i64,

    /// The nanosecond offset converted from `startTimeInSeconds`.
    start_time_offset_in_nanos: ?i32 = null,

    /// The interpolation type.
    ///
    /// Valid values: `LINEAR_INTERPOLATION | LOCF_INTERPOLATION`
    ///
    /// * `LINEAR_INTERPOLATION` – Estimates missing data using [linear
    /// interpolation](https://en.wikipedia.org/wiki/Linear_interpolation).
    ///
    /// For example, you can use this operation to return the interpolated
    /// temperature values
    /// for a wind turbine every 24 hours over a duration of 7 days. If the
    /// interpolation starts
    /// July 1, 2021, at 9 AM, IoT SiteWise returns the first interpolated value on
    /// July 2, 2021, at 9 AM,
    /// the second interpolated value on July 3, 2021, at 9 AM, and so on.
    ///
    /// * `LOCF_INTERPOLATION` – Estimates missing data using last observation
    /// carried forward interpolation
    ///
    /// If no data point is found for an interval, IoT SiteWise returns the last
    /// observed data point
    /// for the previous interval and carries forward this interpolated value until
    /// a new data
    /// point is found.
    ///
    /// For example, you can get the state of an on-off valve every 24 hours over a
    /// duration
    /// of 7 days. If the interpolation starts July 1, 2021, at 9 AM, IoT SiteWise
    /// returns the last
    /// observed data point between July 1, 2021, at 9 AM and July 2, 2021, at 9 AM
    /// as the first
    /// interpolated value. If a data point isn't found after 9 AM on July 2, 2021,
    /// IoT SiteWise uses the
    /// same interpolated value for the rest of the days.
    @"type": []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .end_time_in_seconds = "endTimeInSeconds",
        .end_time_offset_in_nanos = "endTimeOffsetInNanos",
        .interval_in_seconds = "intervalInSeconds",
        .interval_window_in_seconds = "intervalWindowInSeconds",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .quality = "quality",
        .start_time_in_seconds = "startTimeInSeconds",
        .start_time_offset_in_nanos = "startTimeOffsetInNanos",
        .@"type" = "type",
    };
};

pub const GetInterpolatedAssetPropertyValuesOutput = struct {
    /// The requested interpolated values.
    interpolated_asset_property_values: ?[]const InterpolatedAssetPropertyValue = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .interpolated_asset_property_values = "interpolatedAssetPropertyValues",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInterpolatedAssetPropertyValuesInput, options: Options) !GetInterpolatedAssetPropertyValuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotsitewise");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetInterpolatedAssetPropertyValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/properties/interpolated";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "assetId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "endTimeInSeconds=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.end_time_in_seconds}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (input.end_time_offset_in_nanos) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "endTimeOffsetInNanos=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "intervalInSeconds=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.interval_in_seconds}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (input.interval_window_in_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "intervalWindowInSeconds=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "nextToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "propertyAlias=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "propertyId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "quality=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(input.quality));
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "startTimeInSeconds=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.start_time_in_seconds}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (input.start_time_offset_in_nanos) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "startTimeOffsetInNanos=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "type=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.@"type");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetInterpolatedAssetPropertyValuesOutput {
    var result: GetInterpolatedAssetPropertyValuesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInterpolatedAssetPropertyValuesOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictingOperationException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
