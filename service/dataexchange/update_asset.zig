const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AssetDetails = @import("asset_details.zig").AssetDetails;
const AssetType = @import("asset_type.zig").AssetType;

pub const UpdateAssetInput = struct {
    /// The unique identifier for an asset.
    asset_id: []const u8,

    /// The unique identifier for a data set.
    data_set_id: []const u8,

    /// The name of the asset. When importing from Amazon S3, the Amazon S3 object
    /// key is used
    /// as the asset name. When exporting to Amazon S3, the asset name is used as
    /// default target
    /// Amazon S3 object key. When importing from Amazon API Gateway API, the API
    /// name is used as
    /// the asset name. When importing from Amazon Redshift, the datashare name is
    /// used as the
    /// asset name. When importing from AWS Lake Formation, the static values of
    /// "Database(s)
    /// included in the LF-tag policy" or "Table(s) included in LF-tag policy" are
    /// used as the
    /// name.
    name: []const u8,

    /// The unique identifier for a revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .data_set_id = "DataSetId",
        .name = "Name",
        .revision_id = "RevisionId",
    };
};

pub const UpdateAssetOutput = struct {
    /// The ARN for the asset.
    arn: ?[]const u8 = null,

    /// Details about the asset.
    asset_details: ?AssetDetails = null,

    /// The type of asset that is added to a data set.
    asset_type: ?AssetType = null,

    /// The date and time that the asset was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The unique identifier for the data set associated with this asset.
    data_set_id: ?[]const u8 = null,

    /// The unique identifier for the asset.
    id: ?[]const u8 = null,

    /// The name of the asset. When importing from Amazon S3, the Amazon S3 object
    /// key is used
    /// as the asset name. When exporting to Amazon S3, the asset name is used as
    /// default target
    /// Amazon S3 object key. When importing from Amazon API Gateway API, the API
    /// name is used as
    /// the asset name. When importing from Amazon Redshift, the datashare name is
    /// used as the
    /// asset name. When importing from AWS Lake Formation, the static values of
    /// "Database(s)
    /// included in the LF-tag policy"- or "Table(s) included in LF-tag policy" are
    /// used as the
    /// asset name.
    name: ?[]const u8 = null,

    /// The unique identifier for the revision associated with this asset.
    revision_id: ?[]const u8 = null,

    /// The asset ID of the owned asset corresponding to the entitled asset being
    /// viewed. This
    /// parameter is returned when an asset owner is viewing the entitled copy of
    /// its owned
    /// asset.
    source_id: ?[]const u8 = null,

    /// The date and time that the asset was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_details = "AssetDetails",
        .asset_type = "AssetType",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .id = "Id",
        .name = "Name",
        .revision_id = "RevisionId",
        .source_id = "SourceId",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetInput, options: CallOptions) !UpdateAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dataexchange");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/data-sets/");
    try path_buf.appendSlice(allocator, input.data_set_id);
    try path_buf.appendSlice(allocator, "/revisions/");
    try path_buf.appendSlice(allocator, input.revision_id);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetOutput {
    var result: UpdateAssetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssetOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
