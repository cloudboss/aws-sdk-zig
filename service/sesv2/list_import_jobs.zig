const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportDestinationType = @import("import_destination_type.zig").ImportDestinationType;
const ImportJobSummary = @import("import_job_summary.zig").ImportJobSummary;

pub const ListImportJobsInput = struct {
    /// The destination of the import job, which can be used to list import jobs
    /// that have a
    /// certain `ImportDestinationType`.
    import_destination_type: ?ImportDestinationType = null,

    /// A string token indicating that there might be additional import jobs
    /// available to be
    /// listed. Copy this token to a subsequent call to `ListImportJobs` with the
    /// same parameters to retrieve the next page of import jobs.
    next_token: ?[]const u8 = null,

    /// Maximum number of import jobs to return at once. Use this parameter to
    /// paginate
    /// results. If additional import jobs exist beyond the specified limit, the
    /// `NextToken` element is sent in the response. Use the
    /// `NextToken` value in subsequent requests to retrieve additional
    /// addresses.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .import_destination_type = "ImportDestinationType",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListImportJobsOutput = struct {
    /// A list of the import job summaries.
    import_jobs: ?[]const ImportJobSummary = null,

    /// A string token indicating that there might be additional import jobs
    /// available to be
    /// listed. Copy this token to a subsequent call to `ListImportJobs` with the
    /// same parameters to retrieve the next page of import jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .import_jobs = "ImportJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImportJobsInput, options: CallOptions) !ListImportJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/import-jobs/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.import_destination_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ImportDestinationType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImportJobsOutput {
    var result: ListImportJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListImportJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
