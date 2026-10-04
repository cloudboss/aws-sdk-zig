const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Format = @import("format.zig").Format;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

pub const CancelImportTaskInput = struct {
    /// The unique identifier of the import task.
    task_identifier: []const u8,

    pub const json_field_names = .{
        .task_identifier = "taskIdentifier",
    };
};

pub const CancelImportTaskOutput = struct {
    /// Specifies the format of S3 data to be imported. Valid values are `CSV`,
    /// which identifies the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html) or `OPENCYPHER`, which identifies the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html).
    format: ?Format = null,

    /// The unique identifier of the Neptune Analytics graph.
    graph_id: ?[]const u8 = null,

    /// The parquet type of the cancelled import task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying to the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot.
    source: []const u8,

    /// Current status of the task. Status is CANCELLING when the import task is
    /// cancelled.
    status: ImportTaskStatus,

    /// The unique identifier of the import task.
    task_id: []const u8,

    pub const json_field_names = .{
        .format = "format",
        .graph_id = "graphId",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .source = "source",
        .status = "status",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelImportTaskInput, options: CallOptions) !CancelImportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/importtasks/");
    try path_buf.appendSlice(allocator, input.task_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelImportTaskOutput {
    var result: CancelImportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelImportTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
