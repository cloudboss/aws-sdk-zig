const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailureInfo = @import("failure_info.zig").FailureInfo;
const ImportDataSource = @import("import_data_source.zig").ImportDataSource;
const ImportDestination = @import("import_destination.zig").ImportDestination;
const JobStatus = @import("job_status.zig").JobStatus;

pub const GetImportJobInput = struct {
    /// The ID of the import job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetImportJobOutput = struct {
    /// The time stamp of when the import job was completed.
    completed_timestamp: ?i64 = null,

    /// The time stamp of when the import job was created.
    created_timestamp: ?i64 = null,

    /// The number of records that failed processing because of invalid input or
    /// other
    /// reasons.
    failed_records_count: ?i32 = null,

    /// The failure details about an import job.
    failure_info: ?FailureInfo = null,

    /// The data source of the import job.
    import_data_source: ?ImportDataSource = null,

    /// The destination of the import job.
    import_destination: ?ImportDestination = null,

    /// A string that represents the import job ID.
    job_id: ?[]const u8 = null,

    /// The status of the import job.
    job_status: ?JobStatus = null,

    /// The current number of records processed.
    processed_records_count: ?i32 = null,

    pub const json_field_names = .{
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .failed_records_count = "FailedRecordsCount",
        .failure_info = "FailureInfo",
        .import_data_source = "ImportDataSource",
        .import_destination = "ImportDestination",
        .job_id = "JobId",
        .job_status = "JobStatus",
        .processed_records_count = "ProcessedRecordsCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportJobInput, options: CallOptions) !GetImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/import-jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportJobOutput {
    var result: GetImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
