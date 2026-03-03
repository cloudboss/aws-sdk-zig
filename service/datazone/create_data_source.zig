const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

pub const CreateDataSourceInput = struct {
    /// The metadata forms that are to be attached to the assets that this data
    /// source works with.
    asset_forms_input: ?[]const FormInput = null,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// Specifies the configuration of the data source. It can be set to either
    /// `glueRunConfiguration` or `redshiftRunConfiguration`.
    configuration: ?DataSourceConfigurationInput = null,

    /// The ID of the connection.
    connection_identifier: ?[]const u8 = null,

    /// The description of the data source.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain where the data source is created.
    domain_identifier: []const u8,

    /// Specifies whether the data source is enabled.
    enable_setting: ?EnableSetting = null,

    /// The unique identifier of the Amazon DataZone environment to which the data
    /// source publishes assets.
    environment_identifier: ?[]const u8 = null,

    /// The name of the data source.
    name: []const u8,

    /// The identifier of the Amazon DataZone project in which you want to add this
    /// data source.
    project_identifier: []const u8,

    /// Specifies whether the assets that this data source creates in the inventory
    /// are to be also automatically published to the catalog.
    publish_on_import: ?bool = null,

    /// Specifies whether the business name generation is to be enabled for this
    /// data source.
    recommendation: ?RecommendationConfiguration = null,

    /// The schedule of the data source runs.
    schedule: ?ScheduleConfiguration = null,

    /// The type of the data source. In Amazon DataZone, you can use data sources to
    /// import technical metadata of assets (data) from the source databases or data
    /// warehouses into Amazon DataZone. In the current release of Amazon DataZone,
    /// you can create and run data sources for Amazon Web Services Glue and Amazon
    /// Redshift.
    @"type": []const u8,

    pub const json_field_names = .{
        .asset_forms_input = "assetFormsInput",
        .client_token = "clientToken",
        .configuration = "configuration",
        .connection_identifier = "connectionIdentifier",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .enable_setting = "enableSetting",
        .environment_identifier = "environmentIdentifier",
        .name = "name",
        .project_identifier = "projectIdentifier",
        .publish_on_import = "publishOnImport",
        .recommendation = "recommendation",
        .schedule = "schedule",
        .@"type" = "type",
    };
};

pub const CreateDataSourceOutput = struct {
    /// The metadata forms attached to the assets that this data source creates.
    asset_forms_output: ?[]const FormOutput = null,

    /// Specifies the configuration of the data source. It can be set to either
    /// `glueRunConfiguration` or `redshiftRunConfiguration`.
    configuration: ?DataSourceConfigurationOutput = null,

    /// The ID of the connection.
    connection_id: ?[]const u8 = null,

    /// The timestamp of when the data source was created.
    created_at: ?i64 = null,

    /// The description of the data source.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the data source is created.
    domain_id: []const u8,

    /// Specifies whether the data source is enabled.
    enable_setting: ?EnableSetting = null,

    /// The unique identifier of the Amazon DataZone environment to which the data
    /// source publishes assets.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    error_message: ?DataSourceErrorMessage = null,

    /// The unique identifier of the data source.
    id: []const u8,

    /// The timestamp that specifies when the data source was last run.
    last_run_at: ?i64 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    last_run_error_message: ?DataSourceErrorMessage = null,

    /// The status of the last run of this data source.
    last_run_status: ?DataSourceRunStatus = null,

    /// The name of the data source.
    name: []const u8,

    /// The ID of the Amazon DataZone project to which the data source is added.
    project_id: []const u8,

    /// Specifies whether the assets that this data source creates in the inventory
    /// are to be also automatically published to the catalog.
    publish_on_import: ?bool = null,

    /// Specifies whether the business name generation is to be enabled for this
    /// data source.
    recommendation: ?RecommendationConfiguration = null,

    /// The schedule of the data source runs.
    schedule: ?ScheduleConfiguration = null,

    /// The status of the data source.
    status: ?DataSourceStatus = null,

    /// The type of the data source.
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
        .schedule = "schedule",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSourceInput, options: Options) !CreateDataSourceOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-sources");
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
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectionIdentifier\":");
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
    if (input.environment_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"projectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.project_identifier), input.project_identifier, allocator, &body_buf);
    has_prev = true;
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
    if (input.schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSourceOutput {
    var result: CreateDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataSourceOutput, body, allocator);
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
