const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertyDataType = @import("property_data_type.zig").PropertyDataType;

pub const DescribeTimeSeriesInput = struct {
    /// The alias that identifies the time series.
    alias: ?[]const u8 = null,

    /// The ID of the asset in which the asset property was created. This can be
    /// either the actual ID in UUID format, or else `externalId:` followed by the
    /// external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: ?[]const u8 = null,

    /// The ID of the asset property. This can be either the actual ID in UUID
    /// format, or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    property_id: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .asset_id = "assetId",
        .property_id = "propertyId",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeTimeSeriesOutput = struct {
    /// The alias that identifies the time series.
    alias: ?[]const u8 = null,

    /// The ID of the asset in which the asset property was created.
    asset_id: ?[]const u8 = null,

    /// The data type of the time series.
    ///
    /// If you specify `STRUCT`, you must also specify `dataTypeSpec` to identify
    /// the type of the structure for this time series.
    data_type: PropertyDataType,

    /// The data type of the structure for this time series. This parameter is
    /// required for time series
    /// that have the `STRUCT` data type.
    ///
    /// The options for this parameter depend on the type of the composite model
    /// in which you created the asset property that is associated with your time
    /// series.
    /// Use `AWS/ALARM_STATE` for alarm state in alarm composite models.
    data_type_spec: ?[]const u8 = null,

    /// The ID of the asset property, in UUID format.
    property_id: ?[]const u8 = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the time series, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:time-series/${TimeSeriesId}`
    time_series_arn: []const u8,

    /// The date that the time series was created, in Unix epoch time.
    time_series_creation_date: i64,

    /// The ID of the time series.
    time_series_id: []const u8,

    /// The date that the time series was last updated, in Unix epoch time.
    time_series_last_update_date: i64,

    /// The name of the workspace.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .asset_id = "assetId",
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .property_id = "propertyId",
        .time_series_arn = "timeSeriesArn",
        .time_series_creation_date = "timeSeriesCreationDate",
        .time_series_id = "timeSeriesId",
        .time_series_last_update_date = "timeSeriesLastUpdateDate",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTimeSeriesInput, options: CallOptions) !DescribeTimeSeriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTimeSeriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/timeseries/describe";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "alias=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "propertyId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.workspace_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "workspaceName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTimeSeriesOutput {
    const result: DescribeTimeSeriesOutput = try aws.json.parseJsonObject(
        DescribeTimeSeriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
