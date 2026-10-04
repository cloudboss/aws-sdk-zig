const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableRecordExpirationJobMetrics = @import("table_record_expiration_job_metrics.zig").TableRecordExpirationJobMetrics;
const TableRecordExpirationJobStatus = @import("table_record_expiration_job_status.zig").TableRecordExpirationJobStatus;

pub const GetTableRecordExpirationJobStatusInput = struct {
    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    pub const json_field_names = .{
        .table_arn = "tableArn",
    };
};

pub const GetTableRecordExpirationJobStatusOutput = struct {
    /// If the job failed, this field contains an error message describing the
    /// failure reason.
    failure_message: ?[]const u8 = null,

    /// The timestamp when the expiration job was last executed.
    last_run_timestamp: ?i64 = null,

    /// Metrics about the most recent expiration job execution, including the number
    /// of records and files deleted.
    metrics: ?TableRecordExpirationJobMetrics = null,

    /// The current status of the most recent expiration job.
    status: TableRecordExpirationJobStatus,

    pub const json_field_names = .{
        .failure_message = "failureMessage",
        .last_run_timestamp = "lastRunTimestamp",
        .metrics = "metrics",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableRecordExpirationJobStatusInput, options: CallOptions) !GetTableRecordExpirationJobStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableRecordExpirationJobStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/table-record-expiration-job-status";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "tableArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.table_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableRecordExpirationJobStatusOutput {
    var result: GetTableRecordExpirationJobStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTableRecordExpirationJobStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
