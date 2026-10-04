const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartColumnStatisticsTaskRunInput = struct {
    /// The ID of the Data Catalog where the table reside. If none is supplied, the
    /// Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// A list of the column names to generate statistics. If none is supplied, all
    /// column names for the table will be used by default.
    column_name_list: ?[]const []const u8 = null,

    /// The name of the database where the table resides.
    database_name: []const u8,

    /// The IAM role that the service assumes to generate statistics.
    role: []const u8,

    /// The percentage of rows used to generate statistics. If none is supplied, the
    /// entire table will be used to generate stats.
    sample_size: ?f64 = null,

    /// Name of the security configuration that is used to encrypt CloudWatch logs
    /// for the column stats task run.
    security_configuration: ?[]const u8 = null,

    /// The name of the table to generate statistics.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogID",
        .column_name_list = "ColumnNameList",
        .database_name = "DatabaseName",
        .role = "Role",
        .sample_size = "SampleSize",
        .security_configuration = "SecurityConfiguration",
        .table_name = "TableName",
    };
};

pub const StartColumnStatisticsTaskRunOutput = struct {
    /// The identifier for the column statistics task run.
    column_statistics_task_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_statistics_task_run_id = "ColumnStatisticsTaskRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartColumnStatisticsTaskRunInput, options: CallOptions) !StartColumnStatisticsTaskRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartColumnStatisticsTaskRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.StartColumnStatisticsTaskRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartColumnStatisticsTaskRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartColumnStatisticsTaskRunOutput, body, allocator);
}
