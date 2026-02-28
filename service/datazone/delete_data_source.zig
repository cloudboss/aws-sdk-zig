const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FormOutput = @import("form_output.zig").FormOutput;
const DataSourceConfigurationOutput = @import("data_source_configuration_output.zig").DataSourceConfigurationOutput;
const EnableSetting = @import("enable_setting.zig").EnableSetting;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const SelfGrantStatusOutput = @import("self_grant_status_output.zig").SelfGrantStatusOutput;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

pub const DeleteDataSourceInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the data source is deleted.
    domain_identifier: []const u8,

    /// The identifier of the data source that is deleted.
    identifier: []const u8,

    /// Specifies that the granted permissions are retained in case of a
    /// self-subscribe functionality failure for a data source.
    retain_permissions_on_revoke_failure: ?bool = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .retain_permissions_on_revoke_failure = "retainPermissionsOnRevokeFailure",
    };
};

pub const DeleteDataSourceOutput = struct {
    /// The asset data forms associated with this data source.
    asset_forms_output: ?[]const FormOutput = null,

    /// The configuration of the data source that is deleted.
    configuration: ?DataSourceConfigurationOutput = null,

    /// The ID of the connection that is deleted.
    connection_id: ?[]const u8 = null,

    /// The timestamp of when this data source was created.
    created_at: ?i64 = null,

    /// The description of the data source that is deleted.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the data source is deleted.
    domain_id: []const u8,

    /// The enable setting of the data source that specifies whether the data source
    /// is enabled or disabled.
    enable_setting: ?EnableSetting = null,

    /// The ID of the environemnt associated with this data source.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    error_message: ?DataSourceErrorMessage = null,

    /// The ID of the data source that is deleted.
    id: []const u8,

    /// The timestamp of when the data source was last run.
    last_run_at: ?i64 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    last_run_error_message: ?DataSourceErrorMessage = null,

    /// The status of the last run of this data source.
    last_run_status: ?DataSourceRunStatus = null,

    /// The name of the data source that is deleted.
    name: []const u8,

    /// The ID of the project in which this data source exists and from which it's
    /// deleted.
    project_id: []const u8,

    /// Specifies whether the assets that this data source creates in the inventory
    /// are to be also automatically published to the catalog.
    publish_on_import: ?bool = null,

    /// Specifies that the granted permissions are retained in case of a
    /// self-subscribe functionality failure for a data source.
    retain_permissions_on_revoke_failure: ?bool = null,

    /// The schedule of runs for this data source.
    schedule: ?ScheduleConfiguration = null,

    /// Specifies the status of the self-granting functionality.
    self_grant_status: ?SelfGrantStatusOutput = null,

    /// The status of this data source.
    status: ?DataSourceStatus = null,

    /// The type of this data source.
    @"type": ?[]const u8 = null,

    /// The timestamp of when this data source was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .asset_forms_output = "assetFormsOutput",
        .configuration = "configuration",
        .connection_id = "connectionId",
        .created_at = "createdAt",
        .description = "description",
        .domain_id = "domainId",
        .enable_setting = "enableSetting",
        .environment_id = "environmentId",
        .error_message = "errorMessage",
        .id = "id",
        .last_run_at = "lastRunAt",
        .last_run_error_message = "lastRunErrorMessage",
        .last_run_status = "lastRunStatus",
        .name = "name",
        .project_id = "projectId",
        .publish_on_import = "publishOnImport",
        .retain_permissions_on_revoke_failure = "retainPermissionsOnRevokeFailure",
        .schedule = "schedule",
        .self_grant_status = "selfGrantStatus",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataSourceInput, options: Options) !DeleteDataSourceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/data-sources/");
    try path_buf.appendSlice(alloc, input.identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "clientToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.retain_permissions_on_revoke_failure) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "retainPermissionsOnRevokeFailure=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .DELETE;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeleteDataSourceOutput {
    var result: DeleteDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteDataSourceOutput, body, alloc);
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
