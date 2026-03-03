const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AssetModelCompositeModel = @import("asset_model_composite_model.zig").AssetModelCompositeModel;
const AssetModelCompositeModelSummary = @import("asset_model_composite_model_summary.zig").AssetModelCompositeModelSummary;
const AssetModelHierarchy = @import("asset_model_hierarchy.zig").AssetModelHierarchy;
const AssetModelProperty = @import("asset_model_property.zig").AssetModelProperty;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;
const AssetModelType = @import("asset_model_type.zig").AssetModelType;
const InterfaceRelationship = @import("interface_relationship.zig").InterfaceRelationship;

pub const DescribeAssetModelInput = struct {
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

    /// Whether or not to exclude asset model properties from the response.
    exclude_properties: ?bool = null,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .asset_model_version = "assetModelVersion",
        .exclude_properties = "excludeProperties",
    };
};

pub const DescribeAssetModelOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the asset model, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset-model/${AssetModelId}`
    asset_model_arn: []const u8,

    /// The list of built-in composite models for the asset model, such as those
    /// with those of
    /// type `AWS/ALARMS`.
    asset_model_composite_models: ?[]const AssetModelCompositeModel = null,

    /// The list of the immediate child custom composite model summaries for the
    /// asset
    /// model.
    asset_model_composite_model_summaries: ?[]const AssetModelCompositeModelSummary = null,

    /// The date the asset model was created, in Unix epoch time.
    asset_model_creation_date: i64,

    /// The asset model's description.
    asset_model_description: []const u8,

    /// The external ID of the asset model, if any.
    asset_model_external_id: ?[]const u8 = null,

    /// A list of asset model hierarchies that each contain a `childAssetModelId`
    /// and a
    /// `hierarchyId` (named `id`). A hierarchy specifies allowed parent/child
    /// asset relationships for an asset model.
    asset_model_hierarchies: ?[]const AssetModelHierarchy = null,

    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    /// The date the asset model was last updated, in Unix epoch time.
    asset_model_last_update_date: i64,

    /// The name of the asset model.
    asset_model_name: []const u8,

    /// The list of asset properties for the asset model.
    ///
    /// This object doesn't include properties that you define in composite models.
    /// You can find
    /// composite model properties in the `assetModelCompositeModels` object.
    asset_model_properties: ?[]const AssetModelProperty = null,

    /// The current status of the asset model, which contains a state and any error
    /// message.
    asset_model_status: ?AssetModelStatus = null,

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

    /// The version of the asset model. See [
    /// Asset model
    /// versions](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/model-active-version.html) in the *IoT SiteWise User Guide*.
    asset_model_version: ?[]const u8 = null,

    /// The entity tag (ETag) is a hash of the retrieved version of the asset model.
    /// It's used to make
    /// concurrent updates safely to the resource. See [Optimistic locking for asset
    /// model
    /// writes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/opt-locking-for-model.html)
    /// in the *IoT SiteWise User Guide*.
    ///
    /// See [ Optimistic locking for asset
    /// model
    /// writes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/opt-locking-for-model.html) in the *IoT SiteWise User Guide*.
    e_tag: ?[]const u8 = null,

    /// A list of interface details that describe the interfaces implemented by this
    /// asset model,
    /// including interface asset model IDs and property mappings.
    interface_details: ?[]const InterfaceRelationship = null,

    pub const json_field_names = .{
        .asset_model_arn = "assetModelArn",
        .asset_model_composite_models = "assetModelCompositeModels",
        .asset_model_composite_model_summaries = "assetModelCompositeModelSummaries",
        .asset_model_creation_date = "assetModelCreationDate",
        .asset_model_description = "assetModelDescription",
        .asset_model_external_id = "assetModelExternalId",
        .asset_model_hierarchies = "assetModelHierarchies",
        .asset_model_id = "assetModelId",
        .asset_model_last_update_date = "assetModelLastUpdateDate",
        .asset_model_name = "assetModelName",
        .asset_model_properties = "assetModelProperties",
        .asset_model_status = "assetModelStatus",
        .asset_model_type = "assetModelType",
        .asset_model_version = "assetModelVersion",
        .e_tag = "eTag",
        .interface_details = "interfaceDetails",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetModelInput, options: Options) !DescribeAssetModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.asset_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetModelVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.exclude_properties) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "excludeProperties=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetModelOutput {
    var result: DescribeAssetModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAssetModelOutput, body, allocator);
    }
    _ = status;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

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
