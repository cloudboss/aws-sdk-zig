const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Quality = @import("quality.zig").Quality;
const TimeOrdering = @import("time_ordering.zig").TimeOrdering;
const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

pub const GetAssetPropertyValueHistoryInput = struct {
    /// The ID of the asset, in UUID format.
    asset_id: ?[]const u8 = null,

    /// The inclusive end of the range from which to query historical data,
    /// expressed in seconds in Unix epoch time.
    end_date: ?i64 = null,

    /// The maximum number of results to return for each paginated request. A result
    /// set is returned in the two cases, whichever occurs
    /// first.
    ///
    /// * The size of the result set is equal to 4 MB.
    ///
    /// * The number of data points in the result set is equal to the value of
    /// `maxResults`. The maximum value of `maxResults` is 20000.
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

    /// The quality by which to filter asset data.
    qualities: ?[]const Quality = null,

    /// The exclusive start of the range from which to query historical data,
    /// expressed in seconds in Unix epoch time.
    start_date: ?i64 = null,

    /// The chronological sorting order of the requested information.
    ///
    /// Default: `ASCENDING`
    time_ordering: ?TimeOrdering = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .end_date = "endDate",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .qualities = "qualities",
        .start_date = "startDate",
        .time_ordering = "timeOrdering",
    };
};

pub const GetAssetPropertyValueHistoryOutput = struct {
    /// The asset property's value history.
    asset_property_value_history: ?[]const AssetPropertyValue = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_property_value_history = "assetPropertyValueHistory",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetPropertyValueHistoryInput, options: CallOptions) !GetAssetPropertyValueHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetPropertyValueHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/properties/history";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.end_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endDate=");
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
    if (input.qualities) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "qualities=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.start_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startDate=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.time_ordering) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timeOrdering=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetPropertyValueHistoryOutput {
    var result: GetAssetPropertyValueHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAssetPropertyValueHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
