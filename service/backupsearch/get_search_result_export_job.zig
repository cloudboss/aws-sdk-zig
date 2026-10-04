const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSpecification = @import("export_specification.zig").ExportSpecification;
const ExportJobStatus = @import("export_job_status.zig").ExportJobStatus;

pub const GetSearchResultExportJobInput = struct {
    /// This is the unique string that identifies a specific export job.
    ///
    /// Required for this operation.
    export_job_identifier: []const u8,

    pub const json_field_names = .{
        .export_job_identifier = "ExportJobIdentifier",
    };
};

pub const GetSearchResultExportJobOutput = struct {
    /// The date and time that an export job completed, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CreationTime` is accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    completion_time: ?i64 = null,

    /// The date and time that an export job was created, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CreationTime` is accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    creation_time: ?i64 = null,

    /// The unique Amazon Resource Name (ARN) that uniquely identifies the export
    /// job.
    export_job_arn: ?[]const u8 = null,

    /// This is the unique string that identifies the specified export job.
    export_job_identifier: []const u8,

    /// The export specification consists of the destination S3 bucket to which the
    /// search results were exported, along with the destination prefix.
    export_specification: ?ExportSpecification = null,

    /// The unique string that identifies the Amazon Resource Name (ARN) of the
    /// specified search job.
    search_job_arn: ?[]const u8 = null,

    /// This is the current status of the export job.
    status: ?ExportJobStatus = null,

    /// A status message is a string that is returned for search job with a status
    /// of `FAILED`, along with steps to remedy and retry the operation.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .export_job_arn = "ExportJobArn",
        .export_job_identifier = "ExportJobIdentifier",
        .export_specification = "ExportSpecification",
        .search_job_arn = "SearchJobArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSearchResultExportJobInput, options: CallOptions) !GetSearchResultExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-search", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSearchResultExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-search", "BackupSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/export-search-jobs/");
    try path_buf.appendSlice(allocator, input.export_job_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSearchResultExportJobOutput {
    var result: GetSearchResultExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSearchResultExportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
