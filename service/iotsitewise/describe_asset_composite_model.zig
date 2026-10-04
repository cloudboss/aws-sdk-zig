const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionDefinition = @import("action_definition.zig").ActionDefinition;
const AssetCompositeModelPathSegment = @import("asset_composite_model_path_segment.zig").AssetCompositeModelPathSegment;
const AssetProperty = @import("asset_property.zig").AssetProperty;
const AssetCompositeModelSummary = @import("asset_composite_model_summary.zig").AssetCompositeModelSummary;

pub const DescribeAssetCompositeModelInput = struct {
    /// The ID of a composite model on this asset. This can be either the actual ID
    /// in UUID format, or else `externalId:` followed by the external ID, if it has
    /// one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_composite_model_id: []const u8,

    /// The ID of the asset. This can be either the actual ID in UUID format, or
    /// else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    pub const json_field_names = .{
        .asset_composite_model_id = "assetCompositeModelId",
        .asset_id = "assetId",
    };
};

pub const DescribeAssetCompositeModelOutput = struct {
    /// The available actions for a composite model on this asset.
    action_definitions: ?[]const ActionDefinition = null,

    /// A description for the composite model.
    asset_composite_model_description: []const u8,

    /// An external ID to assign to the asset model.
    ///
    /// If the composite model is a component-based composite model, or one nested
    /// inside a
    /// component model, you can only set the external ID using
    /// `UpdateAssetModelCompositeModel` and specifying the derived ID of the model
    /// or
    /// property from the created model it's a part of.
    asset_composite_model_external_id: ?[]const u8 = null,

    /// The ID of a composite model on this asset.
    asset_composite_model_id: []const u8,

    /// The unique, friendly name for the composite model.
    asset_composite_model_name: []const u8,

    /// The path to the composite model listing the parent composite models.
    asset_composite_model_path: ?[]const AssetCompositeModelPathSegment = null,

    /// The property definitions of the composite model that was used to create the
    /// asset.
    asset_composite_model_properties: ?[]const AssetProperty = null,

    /// The list of composite model summaries.
    asset_composite_model_summaries: ?[]const AssetCompositeModelSummary = null,

    /// The composite model type. Valid values are `AWS/ALARM`, `CUSTOM`, or
    /// ` AWS/L4E_ANOMALY`.
    asset_composite_model_type: []const u8,

    /// The ID of the asset, in UUID format. This ID uniquely identifies the asset
    /// within IoT SiteWise and can be used with other
    /// IoT SiteWise APIs.
    asset_id: []const u8,

    pub const json_field_names = .{
        .action_definitions = "actionDefinitions",
        .asset_composite_model_description = "assetCompositeModelDescription",
        .asset_composite_model_external_id = "assetCompositeModelExternalId",
        .asset_composite_model_id = "assetCompositeModelId",
        .asset_composite_model_name = "assetCompositeModelName",
        .asset_composite_model_path = "assetCompositeModelPath",
        .asset_composite_model_properties = "assetCompositeModelProperties",
        .asset_composite_model_summaries = "assetCompositeModelSummaries",
        .asset_composite_model_type = "assetCompositeModelType",
        .asset_id = "assetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetCompositeModelInput, options: CallOptions) !DescribeAssetCompositeModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetCompositeModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    try path_buf.appendSlice(allocator, "/composite-models/");
    try path_buf.appendSlice(allocator, input.asset_composite_model_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetCompositeModelOutput {
    var result: DescribeAssetCompositeModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAssetCompositeModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
