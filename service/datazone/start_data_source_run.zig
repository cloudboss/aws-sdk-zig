const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataSourceRunInput, options: CallOptions) !StartDataSourceRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataSourceRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-sources/");
    try path_buf.appendSlice(allocator, input.data_source_identifier);
    try path_buf.appendSlice(allocator, "/runs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataSourceRunOutput {
    const result: StartDataSourceRunOutput = try aws.json.parseJsonObject(
        StartDataSourceRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
