const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetCompositeModel = @import("asset_composite_model.zig").AssetCompositeModel;
const AssetCompositeModelSummary = @import("asset_composite_model_summary.zig").AssetCompositeModelSummary;
const AssetHierarchy = @import("asset_hierarchy.zig").AssetHierarchy;
const AssetProperty = @import("asset_property.zig").AssetProperty;
const AssetStatus = @import("asset_status.zig").AssetStatus;

pub const DescribeAssetInput = struct {
    /// The ID of the asset. This can be either the actual ID in UUID format, or
    /// else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    /// Whether or not to exclude asset properties from the response.
    exclude_properties: ?bool = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .exclude_properties = "excludeProperties",
    };
};

pub const DescribeAssetOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the asset, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset/${AssetId}`
    asset_arn: []const u8,

    /// The composite models for the asset.
    asset_composite_models: ?[]const AssetCompositeModel = null,

    /// The list of the immediate child custom composite model summaries for the
    /// asset.
    asset_composite_model_summaries: ?[]const AssetCompositeModelSummary = null,

    /// The date the asset was created, in Unix epoch time.
    asset_creation_date: i64,

    /// A description for the asset.
    asset_description: ?[]const u8 = null,

    /// The external ID of the asset, if any.
    asset_external_id: ?[]const u8 = null,

    /// A list of asset hierarchies that each contain a `hierarchyId`. A hierarchy
    /// specifies allowed parent/child asset relationships.
    asset_hierarchies: ?[]const AssetHierarchy = null,

    /// The ID of the asset, in UUID format.
    asset_id: []const u8,

    /// The date the asset was last updated, in Unix epoch time.
    asset_last_update_date: i64,

    /// The ID of the asset model that was used to create the asset.
    asset_model_id: []const u8,

    /// The name of the asset.
    asset_name: []const u8,

    /// The list of asset properties for the asset.
    ///
    /// This object doesn't include properties that you define in composite models.
    /// You can find
    /// composite model properties in the `assetCompositeModels` object.
    asset_properties: ?[]const AssetProperty = null,

    /// The current status of the asset, which contains a state and any error
    /// message.
    asset_status: ?AssetStatus = null,

    pub const json_field_names = .{
        .asset_arn = "assetArn",
        .asset_composite_models = "assetCompositeModels",
        .asset_composite_model_summaries = "assetCompositeModelSummaries",
        .asset_creation_date = "assetCreationDate",
        .asset_description = "assetDescription",
        .asset_external_id = "assetExternalId",
        .asset_hierarchies = "assetHierarchies",
        .asset_id = "assetId",
        .asset_last_update_date = "assetLastUpdateDate",
        .asset_model_id = "assetModelId",
        .asset_name = "assetName",
        .asset_properties = "assetProperties",
        .asset_status = "assetStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetInput, options: CallOptions) !DescribeAssetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.exclude_properties) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "excludeProperties=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetOutput {
    const result: DescribeAssetOutput = try aws.json.parseJsonObject(
        DescribeAssetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
