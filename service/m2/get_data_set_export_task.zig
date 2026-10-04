const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSetTaskLifecycle = @import("data_set_task_lifecycle.zig").DataSetTaskLifecycle;
const DataSetExportSummary = @import("data_set_export_summary.zig").DataSetExportSummary;

pub const GetDataSetExportTaskInput = struct {
    /// The application identifier.
    application_id: []const u8,

    /// The task identifier returned by the CreateDataSetExportTask operation.
    task_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .task_id = "taskId",
    };
};

pub const GetDataSetExportTaskOutput = struct {
    /// The identifier of a customer managed key used for exported data set
    /// encryption.
    kms_key_arn: ?[]const u8 = null,

    /// The status of the task.
    status: DataSetTaskLifecycle,

    /// If dataset export failed, the failure reason will show here.
    status_reason: ?[]const u8 = null,

    /// A summary of the status of the task.
    summary: ?DataSetExportSummary = null,

    /// The task identifier.
    task_id: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .status = "status",
        .status_reason = "statusReason",
        .summary = "summary",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSetExportTaskInput, options: CallOptions) !GetDataSetExportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSetExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/dataset-export-tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSetExportTaskOutput {
    const result: GetDataSetExportTaskOutput = try aws.json.parseJsonObject(
        GetDataSetExportTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
