const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeSeriesEntityType = @import("time_series_entity_type.zig").TimeSeriesEntityType;
const TimeSeriesDataPointFormOutput = @import("time_series_data_point_form_output.zig").TimeSeriesDataPointFormOutput;

pub const GetTimeSeriesDataPointInput = struct {
    /// The ID of the Amazon DataZone domain that houses the asset for which you
    /// want to get the data point.
    domain_identifier: []const u8,

    /// The ID of the asset for which you want to get the data point.
    entity_identifier: []const u8,

    /// The type of the asset for which you want to get the data point.
    entity_type: TimeSeriesEntityType,

    /// The name of the time series form that houses the data point that you want to
    /// get.
    form_name: []const u8,

    /// The ID of the data point that you want to get.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_type = "entityType",
        .form_name = "formName",
        .identifier = "identifier",
    };
};

pub const GetTimeSeriesDataPointOutput = struct {
    /// The ID of the Amazon DataZone domain that houses the asset data point that
    /// you want to get.
    domain_id: ?[]const u8 = null,

    /// The ID of the asset for which you want to get the data point.
    entity_id: ?[]const u8 = null,

    /// The type of the asset for which you want to get the data point.
    entity_type: ?TimeSeriesEntityType = null,

    /// The time series form that houses the data point that you want to get.
    form: ?TimeSeriesDataPointFormOutput = null,

    /// The name of the time series form that houses the data point that you want to
    /// get.
    form_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .entity_id = "entityId",
        .entity_type = "entityType",
        .form = "form",
        .form_name = "formName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTimeSeriesDataPointInput, options: CallOptions) !GetTimeSeriesDataPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTimeSeriesDataPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.entity_identifier);
    try path_buf.appendSlice(allocator, "/time-series-data-points/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "formName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.form_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTimeSeriesDataPointOutput {
    var result: GetTimeSeriesDataPointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTimeSeriesDataPointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
