const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const RunStatisticsForAssets = @import("run_statistics_for_assets.zig").RunStatisticsForAssets;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const DataSourceRunType = @import("data_source_run_type.zig").DataSourceRunType;

pub const StartDataSourceRunInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The identifier of the data source.
    data_source_identifier: []const u8,

    /// The identifier of the Amazon DataZone domain in which to start a data source
    /// run.
    domain_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data_source_identifier = "dataSourceIdentifier",
        .domain_identifier = "domainIdentifier",
    };
};

pub const StartDataSourceRunOutput = struct {
    /// The timestamp of when data source run was created.
    created_at: i64,

    /// The configuration snapshot of the data source that is being run.
    data_source_configuration_snapshot: ?[]const u8 = null,

    /// The identifier of the data source.
    data_source_id: []const u8,

    /// The identifier of the Amazon DataZone domain in which to start a data source
    /// run.
    domain_id: []const u8,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    error_message: ?DataSourceErrorMessage = null,

    /// The identifier of the data source run.
    id: []const u8,

    /// The identifier of the project.
    project_id: []const u8,

    /// Specifies run statistics for assets.
    run_statistics_for_assets: ?RunStatisticsForAssets = null,

    /// The timestamp of when the data source run was started.
    started_at: ?i64 = null,

    /// The status of the data source run.
    status: DataSourceRunStatus,

    /// The timestamp of when the data source run was stopped.
    stopped_at: ?i64 = null,

    /// The type of the data source run.
    @"type": DataSourceRunType,

    /// The timestamp of when the data source run was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_source_configuration_snapshot = "dataSourceConfigurationSnapshot",
        .data_source_id = "dataSourceId",
        .domain_id = "domainId",
        .error_message = "errorMessage",
        .id = "id",
        .project_id = "projectId",
        .run_statistics_for_assets = "runStatisticsForAssets",
        .started_at = "startedAt",
        .status = "status",
        .stopped_at = "stoppedAt",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataSourceRunInput, options: Options) !StartDataSourceRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartDataSourceRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/data-sources/");
    try path_buf.appendSlice(alloc, input.data_source_identifier);
    try path_buf.appendSlice(alloc, "/runs");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartDataSourceRunOutput {
    var result: StartDataSourceRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartDataSourceRunOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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
