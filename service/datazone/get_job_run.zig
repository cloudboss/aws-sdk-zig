const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobRunDetails = @import("job_run_details.zig").JobRunDetails;
const JobRunError = @import("job_run_error.zig").JobRunError;
const JobType = @import("job_type.zig").JobType;
const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const JobRunStatus = @import("job_run_status.zig").JobRunStatus;

pub const GetJobRunInput = struct {
    /// The ID of the domain.
    domain_identifier: []const u8,

    /// The ID of the job run.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetJobRunOutput = struct {
    /// The timestamp of when the job run was created.
    created_at: ?i64 = null,

    /// The user who created the job run.
    created_by: ?[]const u8 = null,

    /// The details of the job run.
    details: ?JobRunDetails = null,

    /// The ID of the domain.
    domain_id: ?[]const u8 = null,

    /// The timestamp of when the job run ended.
    end_time: ?i64 = null,

    /// The error generated if the action is not completed successfully.
    @"error": ?JobRunError = null,

    /// The ID of the job run.
    id: ?[]const u8 = null,

    /// The ID of the job run.
    job_id: ?[]const u8 = null,

    /// The type of the job run.
    job_type: ?JobType = null,

    /// The mode of the job run.
    run_mode: ?JobRunMode = null,

    /// The timestamp of when the job run started.
    start_time: ?i64 = null,

    /// The status of the job run.
    status: ?JobRunStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .details = "details",
        .domain_id = "domainId",
        .end_time = "endTime",
        .@"error" = "error",
        .id = "id",
        .job_id = "jobId",
        .job_type = "jobType",
        .run_mode = "runMode",
        .start_time = "startTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobRunInput, options: CallOptions) !GetJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/jobRuns/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobRunOutput {
    var result: GetJobRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetJobRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
