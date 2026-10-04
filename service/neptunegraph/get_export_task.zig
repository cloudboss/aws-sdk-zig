const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFilter = @import("export_filter.zig").ExportFilter;
const ExportTaskDetails = @import("export_task_details.zig").ExportTaskDetails;
const ExportFormat = @import("export_format.zig").ExportFormat;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ExportTaskStatus = @import("export_task_status.zig").ExportTaskStatus;

pub const GetExportTaskInput = struct {
    /// The unique identifier of the export task.
    task_identifier: []const u8,

    pub const json_field_names = .{
        .task_identifier = "taskIdentifier",
    };
};

pub const GetExportTaskOutput = struct {
    /// The Amazon S3 URI of the export task where data will be exported.
    destination: []const u8,

    /// The export filter of the export task.
    export_filter: ?ExportFilter = null,

    /// The details of the export task.
    export_task_details: ?ExportTaskDetails = null,

    /// The format of the export task.
    format: ExportFormat,

    /// The source graph identifier of the export task.
    graph_id: []const u8,

    /// The KMS key identifier of the export task.
    kms_key_identifier: []const u8,

    /// The parquet type of the export task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow data to be exported to the
    /// destination.
    role_arn: []const u8,

    /// The current status of the export task.
    status: ExportTaskStatus,

    /// The reason that the export task has this status value.
    status_reason: ?[]const u8 = null,

    /// The unique identifier of the export task.
    task_id: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .export_filter = "exportFilter",
        .export_task_details = "exportTaskDetails",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportTaskInput, options: CallOptions) !GetExportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exporttasks/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportTaskOutput {
    var result: GetExportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetExportTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
