const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FormInput = @import("form_input.zig").FormInput;
const DataSourceConfigurationInput = @import("data_source_configuration_input.zig").DataSourceConfigurationInput;
const EnableSetting = @import("enable_setting.zig").EnableSetting;
const RecommendationConfiguration = @import("recommendation_configuration.zig").RecommendationConfiguration;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const FormOutput = @import("form_output.zig").FormOutput;
const DataSourceConfigurationOutput = @import("data_source_configuration_output.zig").DataSourceConfigurationOutput;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const SelfGrantStatusOutput = @import("self_grant_status_output.zig").SelfGrantStatusOutput;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

pub const UpdateDataSourceInput = struct {
    /// The asset forms to be updated as part of the `UpdateDataSource` action.
    asset_forms_input: ?[]const FormInput = null,

    /// The configuration to be updated as part of the `UpdateDataSource` action.
    configuration: ?DataSourceConfigurationInput = null,

    /// The description to be updated as part of the `UpdateDataSource` action.
    description: ?[]const u8 = null,

    /// The identifier of the domain in which to update a data source.
    domain_identifier: []const u8,

    /// The enable setting to be updated as part of the `UpdateDataSource` action.
    enable_setting: ?EnableSetting = null,

    /// The identifier of the data source to be updated.
    identifier: []const u8,

    /// The name to be updated as part of the `UpdateDataSource` action.
    name: ?[]const u8 = null,

    /// The publish on import setting to be updated as part of the
    /// `UpdateDataSource` action.
    publish_on_import: ?bool = null,

    /// The recommendation to be updated as part of the `UpdateDataSource` action.
    recommendation: ?RecommendationConfiguration = null,

    /// Specifies that the granted permissions are retained in case of a
    /// self-subscribe functionality failure for a data source.
    retain_permissions_on_revoke_failure: ?bool = null,

    /// The schedule to be updated as part of the `UpdateDataSource` action.
    schedule: ?ScheduleConfiguration = null,

    pub const json_field_names = .{
        .asset_forms_input = "assetFormsInput",
        .configuration = "configuration",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .enable_setting = "enableSetting",
        .identifier = "identifier",
        .name = "name",
        .publish_on_import = "publishOnImport",
        .recommendation = "recommendation",
        .retain_permissions_on_revoke_failure = "retainPermissionsOnRevokeFailure",
        .schedule = "schedule",
    };
};

pub const UpdateDataSourceOutput = struct {
    /// The asset forms to be updated as part of the `UpdateDataSource` action.
    asset_forms_output: ?[]const FormOutput = null,

    /// The configuration to be updated as part of the `UpdateDataSource` action.
    configuration: ?DataSourceConfigurationOutput = null,

    /// The connection ID.
    connection_id: ?[]const u8 = null,

    /// The timestamp of when the data source was updated.
    created_at: ?i64 = null,

    /// The description to be updated as part of the `UpdateDataSource` action.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which a data source is to be
    /// updated.
    domain_id: []const u8,

    /// The enable setting to be updated as part of the `UpdateDataSource` action.
    enable_setting: ?EnableSetting = null,

    /// The identifier of the environment in which a data source is to be updated.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    error_message: ?DataSourceErrorMessage = null,

    /// The identifier of the data source to be updated.
    id: []const u8,

    /// The timestamp of when the data source was last run.
    last_run_at: ?i64 = null,

    /// The last run error message of the data source.
    last_run_error_message: ?DataSourceErrorMessage = null,

    /// The last run status of the data source.
    last_run_status: ?DataSourceRunStatus = null,

    /// The name to be updated as part of the `UpdateDataSource` action.
    name: []const u8,

    /// The identifier of the project where data source is to be updated.
    project_id: []const u8,

    /// The publish on import setting to be updated as part of the
    /// `UpdateDataSource` action.
    publish_on_import: ?bool = null,

    /// The recommendation to be updated as part of the `UpdateDataSource` action.
    recommendation: ?RecommendationConfiguration = null,

    /// Specifies that the granted permissions are retained in case of a
    /// self-subscribe functionality failure for a data source.
    retain_permissions_on_revoke_failure: ?bool = null,

    /// The schedule to be updated as part of the `UpdateDataSource` action.
    schedule: ?ScheduleConfiguration = null,

    /// Specifies the status of the self-granting functionality.
    self_grant_status: ?SelfGrantStatusOutput = null,

    /// The status to be updated as part of the `UpdateDataSource` action.
    status: ?DataSourceStatus = null,

    /// The type to be updated as part of the `UpdateDataSource` action.
    @"type": ?[]const u8 = null,

    /// The timestamp of when the data source was updated.
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
        .recommendation = "recommendation",
        .retain_permissions_on_revoke_failure = "retainPermissionsOnRevokeFailure",
        .schedule = "schedule",
        .self_grant_status = "selfGrantStatus",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: CallOptions) !UpdateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-sources/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_forms_input) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetFormsInput\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.publish_on_import) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"publishOnImport\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recommendation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recommendation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retain_permissions_on_revoke_failure) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retainPermissionsOnRevokeFailure\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataSourceOutput {
    var result: UpdateDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDataSourceOutput, body, allocator);
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
