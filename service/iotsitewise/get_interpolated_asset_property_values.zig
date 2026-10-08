const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    type: []const u8,

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
        .type = "type",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInterpolatedAssetPropertyValuesInput, options: CallOptions) !GetInterpolatedAssetPropertyValuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInterpolatedAssetPropertyValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/properties/interpolated";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTimeInSeconds=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time_in_seconds}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.end_time_offset_in_nanos) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTimeOffsetInNanos=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "intervalInSeconds=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.interval_in_seconds}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.interval_window_in_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "intervalWindowInSeconds=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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
    if (input.property_alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "propertyAlias=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "propertyId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "quality=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.quality.wireName());
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startTimeInSeconds=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time_in_seconds}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.start_time_offset_in_nanos) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTimeOffsetInNanos=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.type);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInterpolatedAssetPropertyValuesOutput {
    const result: GetInterpolatedAssetPropertyValuesOutput = try aws.json.parseJsonObject(
        GetInterpolatedAssetPropertyValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
