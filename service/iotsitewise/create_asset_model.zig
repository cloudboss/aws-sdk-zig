const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelCompositeModelDefinition = @import("asset_model_composite_model_definition.zig").AssetModelCompositeModelDefinition;
const AssetModelHierarchyDefinition = @import("asset_model_hierarchy_definition.zig").AssetModelHierarchyDefinition;
const AssetModelPropertyDefinition = @import("asset_model_property_definition.zig").AssetModelPropertyDefinition;
const AssetModelType = @import("asset_model_type.zig").AssetModelType;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const CreateAssetModelInput = struct {
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
    asset_model_composite_models: ?[]const AssetModelCompositeModelDefinition = null,

    /// A description for the asset model.
    asset_model_description: ?[]const u8 = null,

    /// An external ID to assign to the asset model. The external ID must be unique
    /// within your Amazon Web Services account. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    asset_model_external_id: ?[]const u8 = null,

    /// The hierarchy definitions of the asset model. Each hierarchy specifies an
    /// asset model
    /// whose assets can be children of any other assets created from this asset
    /// model. For more
    /// information, see [Asset
    /// hierarchies](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-hierarchies.html) in the *IoT SiteWise User Guide*.
    ///
    /// You can specify up to 10 hierarchies per asset model. For more
    /// information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    asset_model_hierarchies: ?[]const AssetModelHierarchyDefinition = null,

    /// The ID to assign to the asset model, if desired. IoT SiteWise automatically
    /// generates a unique ID for you, so this parameter is never required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    asset_model_id: ?[]const u8 = null,

    /// A unique name for the asset model.
    asset_model_name: []const u8,

    /// The property definitions of the asset model. For more information, see
    /// [Asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html) in the *IoT SiteWise User Guide*.
    ///
    /// You can specify up to 200 properties per asset model. For more
    /// information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    asset_model_properties: ?[]const AssetModelPropertyDefinition = null,

    /// The type of asset model.
    ///
    /// * **ASSET_MODEL** – (default) An asset model that you can use to create
    ///   assets.
    /// Can't be included as a component in another asset model.
    ///
    /// * **COMPONENT_MODEL** – A reusable component that you can include in the
    ///   composite
    /// models of other asset models. You can't create assets directly from this
    /// type of asset model.
    asset_model_type: ?AssetModelType = null,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// A list of key-value pairs that contain metadata for the asset model. For
    /// more information,
    /// see [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .asset_model_composite_models = "assetModelCompositeModels",
        .asset_model_description = "assetModelDescription",
        .asset_model_external_id = "assetModelExternalId",
        .asset_model_hierarchies = "assetModelHierarchies",
        .asset_model_id = "assetModelId",
        .asset_model_name = "assetModelName",
        .asset_model_properties = "assetModelProperties",
        .asset_model_type = "assetModelType",
        .client_token = "clientToken",
        .tags = "tags",
    };
};

pub const CreateAssetModelOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the asset model, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset-model/${AssetModelId}`
    asset_model_arn: []const u8,

    /// The ID of the asset model, in UUID format. You can use this ID when you call
    /// other IoT SiteWise API operations.
    asset_model_id: []const u8,

    /// The status of the asset model, which contains a state (`CREATING` after
    /// successfully calling this operation) and any error message.
    asset_model_status: ?AssetModelStatus = null,

    pub const json_field_names = .{
        .asset_model_arn = "assetModelArn",
        .asset_model_id = "assetModelId",
        .asset_model_status = "assetModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssetModelInput, options: CallOptions) !CreateAssetModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssetModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/asset-models";

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
    if (input.asset_model_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelId\":");
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
    if (input.asset_model_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssetModelOutput {
    const result: CreateAssetModelOutput = try aws.json.parseJsonObject(
        CreateAssetModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
