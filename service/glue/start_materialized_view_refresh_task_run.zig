const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartMaterializedViewRefreshTaskRunInput = struct {
    /// The ID of the Data Catalog where the table reside. If none is supplied, the
    /// account ID is used by default.
    catalog_id: []const u8,

    /// The name of the database where the table resides.
    database_name: []const u8,

    /// Specifies whether this is a full refresh of the task run.
    full_refresh: ?bool = null,

    /// The name of the materialized view to run the refresh task for.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .full_refresh = "FullRefresh",
        .table_name = "TableName",
    };
};

pub const StartMaterializedViewRefreshTaskRunOutput = struct {
    /// The identifier for the materialized view refresh task run.
    materialized_view_refresh_task_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .materialized_view_refresh_task_run_id = "MaterializedViewRefreshTaskRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMaterializedViewRefreshTaskRunInput, options: CallOptions) !StartMaterializedViewRefreshTaskRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMaterializedViewRefreshTaskRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.StartMaterializedViewRefreshTaskRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMaterializedViewRefreshTaskRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMaterializedViewRefreshTaskRunOutput, body, allocator);
}
