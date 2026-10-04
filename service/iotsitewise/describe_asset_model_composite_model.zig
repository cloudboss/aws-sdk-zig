const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionDefinition = @import("action_definition.zig").ActionDefinition;
const AssetModelCompositeModelPathSegment = @import("asset_model_composite_model_path_segment.zig").AssetModelCompositeModelPathSegment;
const AssetModelProperty = @import("asset_model_property.zig").AssetModelProperty;
const AssetModelCompositeModelSummary = @import("asset_model_composite_model_summary.zig").AssetModelCompositeModelSummary;
const CompositionDetails = @import("composition_details.zig").CompositionDetails;

pub const DescribeAssetModelCompositeModelInput = struct {
    /// The ID of a composite model on this asset model. This can be either the
    /// actual ID in UUID format, or else `externalId:` followed by the external ID,
    /// if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_model_composite_model_id: []const u8,

    /// The ID of the asset model. This can be either the actual ID in UUID format,
    /// or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_model_id: []const u8,

    /// The version alias that specifies the latest or active version of the asset
    /// model.
    /// The details are returned in the response. The default value is `LATEST`. See
    /// [
    /// Asset model
    /// versions](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/model-active-version.html) in the *IoT SiteWise User Guide*.
    asset_model_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_id = "assetModelId",
        .asset_model_version = "assetModelVersion",
    };
};

pub const DescribeAssetModelCompositeModelOutput = struct {
    /// The available actions for a composite model on this asset model.
    action_definitions: ?[]const ActionDefinition = null,

    /// The description for the composite model.
    asset_model_composite_model_description: []const u8,

    /// The external ID of a composite model on this asset model.
    asset_model_composite_model_external_id: ?[]const u8 = null,

    /// The ID of a composite model on this asset model.
    asset_model_composite_model_id: []const u8,

    /// The unique, friendly name for the composite model.
    asset_model_composite_model_name: []const u8,

    /// The path to the composite model listing the parent composite models.
    asset_model_composite_model_path: ?[]const AssetModelCompositeModelPathSegment = null,

    /// The property definitions of the composite model.
    asset_model_composite_model_properties: ?[]const AssetModelProperty = null,

    /// The list of composite model summaries for the composite model.
    asset_model_composite_model_summaries: ?[]const AssetModelCompositeModelSummary = null,

    /// The composite model type. Valid values are `AWS/ALARM`, `CUSTOM`, or
    /// ` AWS/L4E_ANOMALY`.
    asset_model_composite_model_type: []const u8,

    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    /// Metadata for the composition relationship established by using
    /// `composedAssetModelId` in [
    /// `CreateAssetModelCompositeModel`
    /// ](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModelCompositeModel.html). For instance, an array detailing the
    /// path of the composition relationship for this composite model.
    composition_details: ?CompositionDetails = null,

    pub const json_field_names = .{
        .action_definitions = "actionDefinitions",
        .asset_model_composite_model_description = "assetModelCompositeModelDescription",
        .asset_model_composite_model_external_id = "assetModelCompositeModelExternalId",
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_composite_model_name = "assetModelCompositeModelName",
        .asset_model_composite_model_path = "assetModelCompositeModelPath",
        .asset_model_composite_model_properties = "assetModelCompositeModelProperties",
        .asset_model_composite_model_summaries = "assetModelCompositeModelSummaries",
        .asset_model_composite_model_type = "assetModelCompositeModelType",
        .asset_model_id = "assetModelId",
        .composition_details = "compositionDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetModelCompositeModelInput, options: CallOptions) !DescribeAssetModelCompositeModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetModelCompositeModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/composite-models/");
    try path_buf.appendSlice(allocator, input.asset_model_composite_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetModelVersion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetModelCompositeModelOutput {
    const result: DescribeAssetModelCompositeModelOutput = try aws.json.parseJsonObject(
        DescribeAssetModelCompositeModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
