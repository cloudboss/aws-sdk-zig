const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobType = @import("job_type.zig").JobType;
const JobSummary = @import("job_summary.zig").JobSummary;

pub const StartJobInput = struct {
    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// The name of the branch to use for the job.
    branch_name: []const u8,

    /// The commit ID from a third-party repository provider for the job.
    commit_id: ?[]const u8 = null,

    /// The commit message from a third-party repository provider for the job.
    commit_message: ?[]const u8 = null,

    /// The commit date and time for the job.
    commit_time: ?i64 = null,

    /// The unique ID for an existing job. This is required if the value of
    /// `jobType` is `RETRY`.
    job_id: ?[]const u8 = null,

    /// A descriptive reason for starting the job.
    job_reason: ?[]const u8 = null,

    /// Describes the type for the job. The job type `RELEASE` starts a new job
    /// with the latest change from the specified branch. This value is available
    /// only for apps
    /// that are connected to a repository.
    ///
    /// The job type `RETRY` retries an existing job. If the job type value is
    /// `RETRY`, the `jobId` is also required.
    job_type: JobType,

    pub const json_field_names = .{
        .app_id = "appId",
        .branch_name = "branchName",
        .commit_id = "commitId",
        .commit_message = "commitMessage",
        .commit_time = "commitTime",
        .job_id = "jobId",
        .job_reason = "jobReason",
        .job_type = "jobType",
    };
};

pub const StartJobOutput = struct {
    /// The summary for the job.
    job_summary: ?JobSummary = null,

    pub const json_field_names = .{
        .job_summary = "jobSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartJobInput, options: CallOptions) !StartJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplify", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/apps/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/branches/");
    try path_buf.appendSlice(allocator, input.branch_name);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.commit_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commitId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.commit_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commitMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.commit_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commitTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobReason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobType\":");
    try aws.json.writeValue(@TypeOf(input.job_type), input.job_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartJobOutput {
    var result: StartJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
