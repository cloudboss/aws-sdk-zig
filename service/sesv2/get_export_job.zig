const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportDataSource = @import("export_data_source.zig").ExportDataSource;
const ExportDestination = @import("export_destination.zig").ExportDestination;
const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const FailureInfo = @import("failure_info.zig").FailureInfo;
const JobStatus = @import("job_status.zig").JobStatus;
const ExportStatistics = @import("export_statistics.zig").ExportStatistics;

pub const GetExportJobInput = struct {
    /// The export job ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetExportJobOutput = struct {
    /// The timestamp of when the export job was completed.
    completed_timestamp: ?i64 = null,

    /// The timestamp of when the export job was created.
    created_timestamp: ?i64 = null,

    /// The data source of the export job.
    export_data_source: ?ExportDataSource = null,

    /// The destination of the export job.
    export_destination: ?ExportDestination = null,

    /// The type of source of the export job.
    export_source_type: ?ExportSourceType = null,

    /// The failure details about an export job.
    failure_info: ?FailureInfo = null,

    /// The export job ID.
    job_id: ?[]const u8 = null,

    /// The status of the export job.
    job_status: ?JobStatus = null,

    /// The statistics about the export job.
    statistics: ?ExportStatistics = null,

    pub const json_field_names = .{
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .export_data_source = "ExportDataSource",
        .export_destination = "ExportDestination",
        .export_source_type = "ExportSourceType",
        .failure_info = "FailureInfo",
        .job_id = "JobId",
        .job_status = "JobStatus",
        .statistics = "Statistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportJobInput, options: CallOptions) !GetExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/export-jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportJobOutput {
    var result: GetExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetExportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
