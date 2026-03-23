const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MedicalScribeJobStatus = @import("medical_scribe_job_status.zig").MedicalScribeJobStatus;
const MedicalScribeJobSummary = @import("medical_scribe_job_summary.zig").MedicalScribeJobSummary;

pub const ListMedicalScribeJobsInput = struct {
    /// Returns only the Medical Scribe jobs that contain the specified string. The
    /// search is not case sensitive.
    job_name_contains: ?[]const u8 = null,

    /// The maximum number of Medical Scribe jobs to return in each page of results.
    /// If
    /// there are fewer results than the value that you specify, only the actual
    /// results are
    /// returned. If you do not specify a value, a default of 5 is used.
    max_results: ?i32 = null,

    /// If your `ListMedicalScribeJobs` request returns more results than
    /// can be displayed, `NextToken` is displayed in the response with an
    /// associated
    /// string. To get the next page of results, copy this string and repeat your
    /// request,
    /// including `NextToken` with the value of the copied string. Repeat as needed
    /// to view all your results.
    next_token: ?[]const u8 = null,

    /// Returns only Medical Scribe jobs with the specified status. Jobs are ordered
    /// by
    /// creation date, with the newest job first. If you do not include `Status`,
    /// all
    /// Medical Scribe jobs are returned.
    status: ?MedicalScribeJobStatus = null,

    pub const json_field_names = .{
        .job_name_contains = "JobNameContains",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListMedicalScribeJobsOutput = struct {
    /// Provides a summary of information about each result.
    medical_scribe_job_summaries: ?[]const MedicalScribeJobSummary = null,

    /// If `NextToken` is present in your response, it indicates that not all
    /// results are displayed. To view the next set of results, copy the string
    /// associated with
    /// the `NextToken` parameter in your results output, then run your request
    /// again
    /// including `NextToken` with the value of the copied string. Repeat as needed
    /// to view all your results.
    next_token: ?[]const u8 = null,

    /// Lists all Medical Scribe jobs that have the status specified in your
    /// request.
    /// Jobs are ordered by creation date, with the newest job first.
    status: ?MedicalScribeJobStatus = null,

    pub const json_field_names = .{
        .medical_scribe_job_summaries = "MedicalScribeJobSummaries",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMedicalScribeJobsInput, options: CallOptions) !ListMedicalScribeJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transcribe");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListMedicalScribeJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.ListMedicalScribeJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMedicalScribeJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMedicalScribeJobsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
