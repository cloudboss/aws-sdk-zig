const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// The status of the asset model, which contains a state (`UPDATING` after
    /// successfully calling this operation) and any error message.
    asset_model_status: ?AssetModelStatus = null,

    pub const json_field_names = .{
        .asset_model_status = "assetModelStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetModelInput, options: Options) !UpdateAssetModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotsitewise");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.match_for_version_type) |v| {
        try request.headers.put(allocator, "Match-For-Version-Type", @tagName(v));
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetModelOutput {
    var result: UpdateAssetModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssetModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingOperationException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
