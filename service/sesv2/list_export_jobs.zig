const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const JobStatus = @import("job_status.zig").JobStatus;
const ExportJobSummary = @import("export_job_summary.zig").ExportJobSummary;

pub const ListExportJobsInput = struct {
    /// A value used to list export jobs that have a certain
    /// `ExportSourceType`.
    export_source_type: ?ExportSourceType = null,

    /// A value used to list export jobs that have a certain `JobStatus`.
    job_status: ?JobStatus = null,

    /// The pagination token returned from a previous call to `ListExportJobs` to
    /// indicate the position in the list of export jobs.
    next_token: ?[]const u8 = null,

    /// Maximum number of export jobs to return at once. Use this parameter to
    /// paginate
    /// results. If additional export jobs exist beyond the specified limit, the
    /// `NextToken` element is sent in the response. Use the
    /// `NextToken` value in subsequent calls to `ListExportJobs` to
    /// retrieve additional export jobs.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .export_source_type = "ExportSourceType",
        .job_status = "JobStatus",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListExportJobsOutput = struct {
    /// A list of the export job summaries.
    export_jobs: ?[]const ExportJobSummary = null,

    /// A string token indicating that there might be additional export jobs
    /// available to be
    /// listed. Use this token to a subsequent call to `ListExportJobs` with the
    /// same
    /// parameters to retrieve the next page of export jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_jobs = "ExportJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportJobsInput, options: CallOptions) !ListExportJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/list-export-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.export_source_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExportSourceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JobStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.page_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PageSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportJobsOutput {
    const result: ListExportJobsOutput = try aws.json.parseJsonObject(
        ListExportJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
