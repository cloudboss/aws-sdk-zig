const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const DataSourceRunLineageSummary = @import("data_source_run_lineage_summary.zig").DataSourceRunLineageSummary;
const RunStatisticsForAssets = @import("run_statistics_for_assets.zig").RunStatisticsForAssets;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const DataSourceRunType = @import("data_source_run_type.zig").DataSourceRunType;

pub const GetDataSourceRunInput = struct {
    /// The ID of the domain in which this data source run was performed.
    domain_identifier: []const u8,

    /// The ID of the data source run.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetDataSourceRunOutput = struct {
    /// The timestamp of when the data source run was created.
    created_at: i64,

    /// The configuration snapshot of the data source run.
    data_source_configuration_snapshot: ?[]const u8 = null,

    /// The ID of the data source for this data source run.
    data_source_id: []const u8,

    /// The ID of the domain in which this data source run was performed.
    domain_id: []const u8,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    error_message: ?DataSourceErrorMessage = null,

    /// The ID of the data source run.
    id: []const u8,

    /// The summary of the data lineage.
    lineage_summary: ?DataSourceRunLineageSummary = null,

    /// The ID of the project in which this data source run occured.
    project_id: []const u8,

    /// The asset statistics from this data source run.
    run_statistics_for_assets: ?RunStatisticsForAssets = null,

    /// The timestamp of when this data source run started.
    started_at: ?i64 = null,

    /// The status of this data source run.
    status: DataSourceRunStatus,

    /// The timestamp of when this data source run stopped.
    stopped_at: ?i64 = null,

    /// The type of this data source run.
    @"type": DataSourceRunType,

    /// The timestamp of when this data source run was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_source_configuration_snapshot = "dataSourceConfigurationSnapshot",
        .data_source_id = "dataSourceId",
        .domain_id = "domainId",
        .error_message = "errorMessage",
        .id = "id",
        .lineage_summary = "lineageSummary",
        .project_id = "projectId",
        .run_statistics_for_assets = "runStatisticsForAssets",
        .started_at = "startedAt",
        .status = "status",
        .stopped_at = "stoppedAt",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSourceRunInput, options: CallOptions) !GetDataSourceRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSourceRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-source-runs/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSourceRunOutput {
    var result: GetDataSourceRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataSourceRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
