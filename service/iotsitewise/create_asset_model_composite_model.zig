const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelPropertyDefinition = @import("asset_model_property_definition.zig").AssetModelPropertyDefinition;
const AssetModelVersionType = @import("asset_model_version_type.zig").AssetModelVersionType;
const AssetModelCompositeModelPathSegment = @import("asset_model_composite_model_path_segment.zig").AssetModelCompositeModelPathSegment;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const CreateAssetModelCompositeModelInput = struct {
    /// A description for the composite model.
    asset_model_composite_model_description: ?[]const u8 = null,

    /// An external ID to assign to the composite model.
    ///
    /// If the composite model is a derived composite model, or one nested inside a
    /// component
    /// model, you can only set the external ID using
    /// `UpdateAssetModelCompositeModel` and
    /// specifying the derived ID of the model or property from the created model
    /// it's a part
    /// of.
    asset_model_composite_model_external_id: ?[]const u8 = null,

    /// The ID of the composite model. IoT SiteWise automatically generates a unique
    /// ID for you, so this
    /// parameter is never required. However, if you prefer to supply your own ID
    /// instead, you can
    /// specify it here in UUID format. If you specify your own ID, it must be
    /// globally unique.
    asset_model_composite_model_id: ?[]const u8 = null,

    /// A unique name for the composite model.
    asset_model_composite_model_name: []const u8,

    /// The property definitions of the composite model. For more information, see [
    /// Inline custom composite
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/custom-composite-models.html#inline-composite-models) in the *IoT SiteWise User Guide*.
    ///
    /// You can specify up to 200 properties per composite model. For more
    /// information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    asset_model_composite_model_properties: ?[]const AssetModelPropertyDefinition = null,

    /// The composite model type. Valid values are `AWS/ALARM`, `CUSTOM`, or `
    /// AWS/L4E_ANOMALY`.
    asset_model_composite_model_type: []const u8,

    /// The ID of the asset model this composite model is a part of.
    asset_model_id: []const u8,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The ID of a component model which is reused to create this composite model.
    composed_asset_model_id: ?[]const u8 = null,

    /// The expected current entity tag (ETag) for the asset model’s latest or
    /// active version (specified using `matchForVersionType`).
    /// The create request is rejected if the tag does not match the latest or
    /// active version's current entity tag.
    /// See [Optimistic locking for asset model
    /// writes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/opt-locking-for-model.html)
    /// in the *IoT SiteWise User Guide*.
    if_match: ?[]const u8 = null,

    /// Accepts ***** to reject the create request if an active version
    /// (specified using `matchForVersionType` as `ACTIVE`) already exists for the
    /// asset model.
    if_none_match: ?[]const u8 = null,

    /// Specifies the asset model version type (`LATEST` or `ACTIVE`) used in
    /// conjunction with `If-Match` or `If-None-Match` headers to determine the
    /// target ETag for the create operation.
    match_for_version_type: ?AssetModelVersionType = null,

    /// The ID of the parent composite model in this asset model relationship.
    parent_asset_model_composite_model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_model_composite_model_description = "assetModelCompositeModelDescription",
        .asset_model_composite_model_external_id = "assetModelCompositeModelExternalId",
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_composite_model_name = "assetModelCompositeModelName",
        .asset_model_composite_model_properties = "assetModelCompositeModelProperties",
        .asset_model_composite_model_type = "assetModelCompositeModelType",
        .asset_model_id = "assetModelId",
        .client_token = "clientToken",
        .composed_asset_model_id = "composedAssetModelId",
        .if_match = "ifMatch",
        .if_none_match = "ifNoneMatch",
        .match_for_version_type = "matchForVersionType",
        .parent_asset_model_composite_model_id = "parentAssetModelCompositeModelId",
    };
};

pub const CreateAssetModelCompositeModelOutput = struct {
    /// The ID of the composed asset model. You can use this ID when you call other
    /// IoT SiteWise
    /// APIs.
    asset_model_composite_model_id: []const u8,

    /// The path to the composite model listing the parent composite models.
    asset_model_composite_model_path: ?[]const AssetModelCompositeModelPathSegment = null,

    /// The ID of the asset model.
    asset_model_id: ?[]const u8 = null,

    asset_model_status: ?AssetModelStatus = null,

    pub const json_field_names = .{
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_composite_model_path = "assetModelCompositeModelPath",
        .asset_model_id = "assetModelId",
        .asset_model_status = "assetModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssetModelCompositeModelInput, options: CallOptions) !CreateAssetModelCompositeModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssetModelCompositeModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/composite-models");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_model_composite_model_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelCompositeModelDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_model_composite_model_external_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelCompositeModelExternalId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_model_composite_model_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelCompositeModelId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assetModelCompositeModelName\":");
    try aws.json.writeValue(@TypeOf(input.asset_model_composite_model_name), input.asset_model_composite_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.asset_model_composite_model_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetModelCompositeModelProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assetModelCompositeModelType\":");
    try aws.json.writeValue(@TypeOf(input.asset_model_composite_model_type), input.asset_model_composite_model_type, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.composed_asset_model_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"composedAssetModelId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_asset_model_composite_model_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentAssetModelCompositeModelId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssetModelCompositeModelOutput {
    const result: CreateAssetModelCompositeModelOutput = try aws.json.parseJsonObject(
        CreateAssetModelCompositeModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
