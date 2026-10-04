const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Format = @import("format.zig").Format;
const ImportOptions = @import("import_options.zig").ImportOptions;
const ImportTaskDetails = @import("import_task_details.zig").ImportTaskDetails;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

pub const GetImportTaskInput = struct {
    /// The unique identifier of the import task.
    task_identifier: []const u8,

    pub const json_field_names = .{
        .task_identifier = "taskIdentifier",
    };
};

pub const GetImportTaskOutput = struct {
    /// The number of the current attempts to execute the import task.
    attempt_number: ?i32 = null,

    /// Specifies the format of S3 data to be imported. Valid values are `CSV`,
    /// which identifies the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html) or `OPENCYPHER`, which identifies the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html).
    format: ?Format = null,

    /// The unique identifier of the Neptune Analytics graph.
    graph_id: ?[]const u8 = null,

    /// Contains options for controlling the import process. For example, if the
    /// `failOnError` key is set to `false`, the import skips problem data and
    /// attempts to continue (whereas if set to `true`, the default, or if omitted,
    /// the import operation halts immediately when an error is encountered.
    import_options: ?ImportOptions = null,

    /// Contains details about the specified import task.
    import_task_details: ?ImportTaskDetails = null,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying to the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot
    source: []const u8,

    /// The status of the import task:
    ///
    /// * **INITIALIZING**   –   The necessary resources needed to create the graph
    ///   are being prepared.
    /// * **ANALYZING_DATA**   –   The data is being analyzed to determine the
    ///   optimal infrastructure configuration for the new graph.
    /// * **RE_PROVISIONING**   –   The data did not fit into the provisioned graph,
    ///   so it is being re-provisioned with more capacity.
    /// * **IMPORTING**   –   The data is being loaded.
    /// * **ERROR_ENCOUNTERED**   –   An error has been encountered while trying to
    ///   create the graph and import the data.
    /// * **ERROR_ENCOUNTERED_ROLLING_BACK**   –   Because of the error that was
    ///   encountered, the graph is being rolled back and all its resources
    ///   released.
    /// * **SUCCEEDED**   –   Graph creation and data loading succeeded.
    /// * **FAILED**   –   Graph creation or data loading failed. When the status is
    ///   `FAILED`, you can use `get-graphs` to get more information about the state
    ///   of the graph.
    /// * **CANCELLING**   –   Because you cancelled the import task, cancellation
    ///   is in progress.
    /// * **CANCELLED**   –   You have successfully cancelled the import task.
    status: ImportTaskStatus,

    /// The reason that the import task has this status value.
    status_reason: ?[]const u8 = null,

    /// The unique identifier of the import task.
    task_id: []const u8,

    pub const json_field_names = .{
        .attempt_number = "attemptNumber",
        .format = "format",
        .graph_id = "graphId",
        .import_options = "importOptions",
        .import_task_details = "importTaskDetails",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .source = "source",
        .status = "status",
        .status_reason = "statusReason",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportTaskInput, options: CallOptions) !GetImportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/importtasks/");
    try path_buf.appendSlice(allocator, input.task_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportTaskOutput {
    var result: GetImportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImportTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
