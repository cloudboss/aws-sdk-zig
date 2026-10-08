const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    type: ?[]const u8 = null,

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
        .type = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataSourceInput, options: CallOptions) !DeleteDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-sources/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.retain_permissions_on_revoke_failure) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "retainPermissionsOnRevokeFailure=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDataSourceOutput {
    const result: DeleteDataSourceOutput = try aws.json.parseJsonObject(
        DeleteDataSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
