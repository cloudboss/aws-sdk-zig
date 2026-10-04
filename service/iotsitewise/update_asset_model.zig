const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelCompositeModel = @import("asset_model_composite_model.zig").AssetModelCompositeModel;
const AssetModelHierarchy = @import("asset_model_hierarchy.zig").AssetModelHierarchy;
const AssetModelProperty = @import("asset_model_property.zig").AssetModelProperty;
const AssetModelVersionType = @import("asset_model_version_type.zig").AssetModelVersionType;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const UpdateAssetModelInput = struct {
    /// The composite models that are part of this asset model. It groups properties
    /// (such as attributes, measurements, transforms, and metrics) and child
    /// composite models that
    /// model parts of your industrial equipment. Each composite model has a type
    /// that defines the
    /// properties that the composite model supports. Use composite models to define
    /// alarms on this asset model.
    ///
    /// When creating custom composite models, you need to use
    /// [CreateAssetModelCompositeModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModelCompositeModel.html). For more information,
    /// see [Creating custom composite models
    /// (Components)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/create-custom-composite-models.html) in the
    /// *IoT SiteWise User Guide*.
    asset_model_composite_models: ?[]const AssetModelCompositeModel = null,

    /// A description for the asset model.
    asset_model_description: ?[]const u8 = null,

    /// An external ID to assign to the asset model. The asset model must not
    /// already have an
    /// external ID. The external ID must be unique within your Amazon Web Services
    /// account. For more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    asset_model_external_id: ?[]const u8 = null,

    /// The updated hierarchy definitions of the asset model. Each hierarchy
    /// specifies an asset
    /// model whose assets can be children of any other assets created from this
    /// asset model. For more
    /// information, see [Asset
    /// hierarchies](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-hierarchies.html) in the *IoT SiteWise User Guide*.
    ///
    /// You can specify up to 10 hierarchies per asset model. For more
    /// information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    asset_model_hierarchies: ?[]const AssetModelHierarchy = null,

    /// The ID of the asset model to update. This can be either the actual ID in
    /// UUID format, or else `externalId:` followed by the external ID, if it has
    /// one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_model_id: []const u8,

    /// A unique name for the asset model.
    asset_model_name: []const u8,

    /// The updated property definitions of the asset model. For more information,
    /// see
    /// [Asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html) in the *IoT SiteWise User Guide*.
    ///
    /// You can specify up to 200 properties per asset model. For more
    /// information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    asset_model_properties: ?[]const AssetModelProperty = null,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The expected current entity tag (ETag) for the asset model’s latest or
    /// active version (specified using `matchForVersionType`).
    /// The update request is rejected if the tag does not match the latest or
    /// active version's current entity tag.
    /// See [Optimistic locking for asset model
    /// writes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/opt-locking-for-model.html)
    /// in the *IoT SiteWise User Guide*.
    if_match: ?[]const u8 = null,

    /// Accepts ***** to reject the update request if an active version
    /// (specified using `matchForVersionType` as `ACTIVE`) already exists for the
    /// asset model.
    if_none_match: ?[]const u8 = null,

    /// Specifies the asset model version type (`LATEST` or `ACTIVE`) used in
    /// conjunction with `If-Match` or `If-None-Match` headers to determine the
    /// target ETag for the update operation.
    match_for_version_type: ?AssetModelVersionType = null,

    pub const json_field_names = .{
        .asset_model_composite_models = "assetModelCompositeModels",
        .asset_model_description = "assetModelDescription",
        .asset_model_external_id = "assetModelExternalId",
        .asset_model_hierarchies = "assetModelHierarchies",
        .asset_model_id = "assetModelId",
        .asset_model_name = "assetModelName",
        .asset_model_properties = "assetModelProperties",
        .client_token = "clientToken",
        .if_match = "ifMatch",
        .if_none_match = "ifNoneMatch",
        .match_for_version_type = "matchForVersionType",
    };
};

pub const UpdateAssetModelOutput = struct {
    /// The ID of the asset model.
    asset_model_id: ?[]const u8 = null,

    /// The status of the asset model, which contains a state (`UPDATING` after
    /// successfully calling this operation) and any error message.
    asset_model_status: ?AssetModelStatus = null,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .asset_model_status = "assetModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetModelInput, options: CallOptions) !UpdateAssetModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_model_composite_models) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelCompositeModels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_model_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_model_external_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelExternalId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_model_hierarchies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelHierarchies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assetModelName\":");
    try aws.json.writeValue(@TypeOf(input.asset_model_name), input.asset_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.asset_model_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.match_for_version_type) |v| {
        try request.headers.put(allocator, "Match-For-Version-Type", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetModelOutput {
    const result: UpdateAssetModelOutput = try aws.json.parseJsonObject(
        UpdateAssetModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
