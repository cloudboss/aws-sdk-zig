const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DocumentEnrichmentConfiguration = @import("document_enrichment_configuration.zig").DocumentEnrichmentConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const UpdateDataSourceInput = struct {
    /// The identifier of the Amazon Q Business application the data source is
    /// attached to.
    application_id: []const u8,

    configuration: ?[]const u8 = null,

    /// The identifier of the data source connector.
    data_source_id: []const u8,

    /// The description of the data source connector.
    description: ?[]const u8 = null,

    /// A name of the data source connector.
    display_name: ?[]const u8 = null,

    document_enrichment_configuration: ?DocumentEnrichmentConfiguration = null,

    /// The identifier of the index attached to the data source connector.
    index_id: []const u8,

    /// The configuration for extracting information from media in documents for
    /// your data source.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access the
    /// data source and required resources.
    role_arn: ?[]const u8 = null,

    /// The chosen update frequency for your data source.
    sync_schedule: ?[]const u8 = null,

    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .configuration = "configuration",
        .data_source_id = "dataSourceId",
        .description = "description",
        .display_name = "displayName",
        .document_enrichment_configuration = "documentEnrichmentConfiguration",
        .index_id = "indexId",
        .media_extraction_configuration = "mediaExtractionConfiguration",
        .role_arn = "roleArn",
        .sync_schedule = "syncSchedule",
        .vpc_configuration = "vpcConfiguration",
    };
};

pub const UpdateDataSourceOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: Options) !UpdateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qbusiness");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_id);
    try path_buf.appendSlice(alloc, "/indices/");
    try path_buf.appendSlice(alloc, input.index_id);
    try path_buf.appendSlice(alloc, "/datasources/");
    try path_buf.appendSlice(alloc, input.data_source_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.document_enrichment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"documentEnrichmentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.media_extraction_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"mediaExtractionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sync_schedule) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"syncSchedule\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.vpc_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"vpcConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDataSourceOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateDataSourceOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
