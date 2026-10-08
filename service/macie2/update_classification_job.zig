const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobStatus = @import("job_status.zig").JobStatus;

pub const UpdateClassificationJobInput = struct {
    /// The unique identifier for the classification job.
    job_id: []const u8,

    /// The new status for the job. Valid values are:
    ///
    /// * CANCELLED - Stops the job permanently and cancels it. This value is valid
    ///   only if the job's current status is IDLE, PAUSED, RUNNING, or USER_PAUSED.
    ///
    /// If you specify this value and the job's current status is RUNNING, Amazon
    /// Macie immediately begins to stop all processing tasks for the job. You can't
    /// resume or restart a job after you cancel it.
    /// * RUNNING - Resumes the job. This value is valid only if the job's current
    ///   status is USER_PAUSED.
    ///
    /// If you paused the job while it was actively running and you specify this
    /// value less than 30 days after you paused the job, Macie immediately resumes
    /// processing from the point where you paused the job. Otherwise, Macie resumes
    /// the job according to the schedule and other settings for the job.
    /// * USER_PAUSED - Pauses the job temporarily. This value is valid only if the
    ///   job's current status is IDLE, PAUSED, or RUNNING. If you specify this
    ///   value and the job's current status is RUNNING, Macie immediately begins to
    ///   pause all processing tasks for the job.
    ///
    /// If you pause a one-time job and you don't resume it within 30 days, the job
    /// expires and Macie cancels the job. If you pause a recurring job when its
    /// status is RUNNING and you don't resume it within 30 days, the job run
    /// expires and Macie cancels the run. To check the expiration date, refer to
    /// the UserPausedDetails.jobExpiresAt property.
    job_status: JobStatus,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_status = "jobStatus",
    };
};

pub const UpdateClassificationJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClassificationJobInput, options: CallOptions) !UpdateClassificationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClassificationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobStatus\":");
    try aws.json.writeValue(@TypeOf(input.job_status), input.job_status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClassificationJobOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateClassificationJobOutput = .{};

    return result;
}
