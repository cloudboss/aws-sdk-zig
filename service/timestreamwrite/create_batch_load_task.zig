const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataModelConfiguration = @import("data_model_configuration.zig").DataModelConfiguration;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const ReportConfiguration = @import("report_configuration.zig").ReportConfiguration;

pub const CreateBatchLoadTaskInput = struct {
    client_token: ?[]const u8 = null,

    data_model_configuration: ?DataModelConfiguration = null,

    /// Defines configuration details about the data source for a batch load task.
    data_source_configuration: DataSourceConfiguration,

    record_version: ?i64 = null,

    report_configuration: ReportConfiguration,

    /// Target Timestream database for a batch load task.
    target_database_name: []const u8,

    /// Target Timestream table for a batch load task.
    target_table_name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_model_configuration = "DataModelConfiguration",
        .data_source_configuration = "DataSourceConfiguration",
        .record_version = "RecordVersion",
        .report_configuration = "ReportConfiguration",
        .target_database_name = "TargetDatabaseName",
        .target_table_name = "TargetTableName",
    };
};

pub const CreateBatchLoadTaskOutput = struct {
    /// The ID of the batch load task.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBatchLoadTaskInput, options: CallOptions) !CreateBatchLoadTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBatchLoadTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ingest.timestream", "Timestream Write", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.CreateBatchLoadTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBatchLoadTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateBatchLoadTaskOutput, body, allocator);
}
