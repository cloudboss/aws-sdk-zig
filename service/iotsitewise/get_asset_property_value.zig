const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

pub const GetAssetPropertyValueInput = struct {
    /// The ID of the asset, in UUID format.
    asset_id: ?[]const u8 = null,

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

    pub const json_field_names = .{
        .asset_id = "assetId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
    };
};

pub const GetAssetPropertyValueOutput = struct {
    /// The current asset property value.
    property_value: ?AssetPropertyValue = null,

    pub const json_field_names = .{
        .property_value = "propertyValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetPropertyValueInput, options: CallOptions) !GetAssetPropertyValueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetPropertyValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/properties/latest";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetPropertyValueOutput {
    const result: GetAssetPropertyValueOutput = try aws.json.parseJsonObject(
        GetAssetPropertyValueOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
