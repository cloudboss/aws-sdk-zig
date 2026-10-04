const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Property = @import("property.zig").Property;
const CompositeModelProperty = @import("composite_model_property.zig").CompositeModelProperty;

pub const DescribeAssetPropertyInput = struct {
    /// The ID of the asset. This can be either the actual ID in UUID format, or
    /// else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    /// The ID of the asset property. This can be either the actual ID in UUID
    /// format, or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .property_id = "propertyId",
    };
};

pub const DescribeAssetPropertyOutput = struct {
    /// The external ID of the asset. For more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    asset_external_id: ?[]const u8 = null,

    /// The ID of the asset, in UUID format.
    asset_id: []const u8,

    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    /// The name of the asset.
    asset_name: []const u8,

    /// The asset property's definition, alias, and notification state.
    ///
    /// This response includes this object for normal asset properties. If you
    /// describe an asset
    /// property in a composite model, this response includes the asset property
    /// information in
    /// `compositeModel`.
    asset_property: ?Property = null,

    /// The composite model that declares this asset property, if this asset
    /// property exists in a
    /// composite model.
    composite_model: ?CompositeModelProperty = null,

    pub const json_field_names = .{
        .asset_external_id = "assetExternalId",
        .asset_id = "assetId",
        .asset_model_id = "assetModelId",
        .asset_name = "assetName",
        .asset_property = "assetProperty",
        .composite_model = "compositeModel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetPropertyInput, options: CallOptions) !DescribeAssetPropertyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetPropertyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    try path_buf.appendSlice(allocator, "/properties/");
    try path_buf.appendSlice(allocator, input.property_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetPropertyOutput {
    var result: DescribeAssetPropertyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAssetPropertyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
