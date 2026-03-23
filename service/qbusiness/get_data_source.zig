const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DocumentEnrichmentConfiguration = @import("document_enrichment_configuration.zig").DocumentEnrichmentConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const GetDataSourceInput = struct {
    /// The identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// The identifier of the data source connector.
    data_source_id: []const u8,

    /// The identfier of the index used with the data source connector.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .index_id = "indexId",
    };
};

pub const GetDataSourceOutput = struct {
    /// The identifier of the Amazon Q Business application.
    application_id: ?[]const u8 = null,

    /// The details of how the data source connector is configured.
    configuration: ?[]const u8 = null,

    /// The Unix timestamp when the data source connector was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data source.
    data_source_arn: ?[]const u8 = null,

    /// The identifier of the data source connector.
    data_source_id: ?[]const u8 = null,

    /// The description for the data source connector.
    description: ?[]const u8 = null,

    /// The name for the data source connector.
    display_name: ?[]const u8 = null,

    document_enrichment_configuration: ?DocumentEnrichmentConfiguration = null,

    /// When the `Status` field value is `FAILED`, the `ErrorMessage` field contains
    /// a description of the error that caused the data source connector to fail.
    @"error": ?ErrorDetail = null,

    /// The identifier of the index linked to the data source connector.
    index_id: ?[]const u8 = null,

    /// The configuration for extracting information from media in documents for the
    /// data source.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the role with permission to access the
    /// data source and required resources.
    role_arn: ?[]const u8 = null,

    /// The current status of the data source connector. When the `Status` field
    /// value is `FAILED`, the `ErrorMessage` field contains a description of the
    /// error that caused the data source connector to fail.
    status: ?DataSourceStatus = null,

    /// The schedule for Amazon Q Business to update the index.
    sync_schedule: ?[]const u8 = null,

    /// The type of the data source connector. For example, `S3`.
    @"type": ?[]const u8 = null,

    /// The Unix timestamp when the data source connector was last updated.
    updated_at: ?i64 = null,

    /// Configuration information for an Amazon VPC (Virtual Private Cloud) to
    /// connect to your data source.
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .configuration = "configuration",
        .created_at = "createdAt",
        .data_source_arn = "dataSourceArn",
        .data_source_id = "dataSourceId",
        .description = "description",
        .display_name = "displayName",
        .document_enrichment_configuration = "documentEnrichmentConfiguration",
        .@"error" = "error",
        .index_id = "indexId",
        .media_extraction_configuration = "mediaExtractionConfiguration",
        .role_arn = "roleArn",
        .status = "status",
        .sync_schedule = "syncSchedule",
        .@"type" = "type",
        .updated_at = "updatedAt",
        .vpc_configuration = "vpcConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSourceInput, options: CallOptions) !GetDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qbusiness");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSourceOutput {
    var result: GetDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataSourceOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ExternalResourceException")) {
        return .{ .arena = arena, .kind = .{ .external_resource_exception = .{
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
    if (std.mem.eql(u8, error_code, "LicenseNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .license_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MediaTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .media_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
