const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFormat = @import("export_format.zig").ExportFormat;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ExportTaskStatus = @import("export_task_status.zig").ExportTaskStatus;

pub const CancelExportTaskInput = struct {
    /// The unique identifier of the export task.
    task_identifier: []const u8,

    pub const json_field_names = .{
        .task_identifier = "taskIdentifier",
    };
};

pub const CancelExportTaskOutput = struct {
    /// The Amazon S3 URI of the cancelled export task where data will be exported
    /// to.
    destination: []const u8,

    /// The format of the cancelled export task.
    format: ExportFormat,

    /// The source graph identifier of the cancelled export task.
    graph_id: []const u8,

    /// The KMS key identifier of the cancelled export task.
    kms_key_identifier: []const u8,

    /// The parquet type of the cancelled export task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow the exporting of data to the
    /// destination.
    role_arn: []const u8,

    /// The current status of the export task. The status is `CANCELLING` when the
    /// export task is cancelled.
    status: ExportTaskStatus,

    /// The reason that the export task has this status value.
    status_reason: ?[]const u8 = null,

    /// The unique identifier of the export task.
    task_id: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .format = "format",
        .graph_id = "graphId",
        .kms_key_identifier = "kmsKeyIdentifier",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .status = "status",
        .status_reason = "statusReason",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelExportTaskInput, options: CallOptions) !CancelExportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exporttasks/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelExportTaskOutput {
    var result: CancelExportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelExportTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
