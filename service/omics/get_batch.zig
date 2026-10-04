const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefaultRunSetting = @import("default_run_setting.zig").DefaultRunSetting;
const RunSummary = @import("run_summary.zig").RunSummary;
const BatchStatus = @import("batch_status.zig").BatchStatus;
const SubmissionSummary = @import("submission_summary.zig").SubmissionSummary;

pub const GetBatchInput = struct {
    /// The identifier portion of the run batch ARN.
    batch_id: []const u8,

    pub const json_field_names = .{
        .batch_id = "batchId",
    };
};

pub const GetBatchOutput = struct {
    /// The unique ARN of the run batch.
    arn: ?[]const u8 = null,

    /// The timestamp when the batch was created.
    creation_time: ?i64 = null,

    /// The shared configuration applied to all runs in the batch. See
    /// `DefaultRunSetting`.
    default_run_setting: ?DefaultRunSetting = null,

    /// The timestamp when the batch transitioned to a `FAILED` status.
    failed_time: ?i64 = null,

    /// A description of the batch failure. Present only when status is `FAILED`.
    failure_reason: ?[]const u8 = null,

    /// The identifier portion of the run batch ARN.
    id: ?[]const u8 = null,

    /// The optional user-friendly name of the batch.
    name: ?[]const u8 = null,

    /// The timestamp when all run executions completed.
    processed_time: ?i64 = null,

    /// A summary of run execution states. Run execution counts are eventually
    /// consistent and may lag behind actual run states. Final counts are accurate
    /// once the batch reaches `PROCESSED` status. See `RunSummary`.
    run_summary: ?RunSummary = null,

    /// The current status of the run batch. Possible values: `CREATING` (initial
    /// setup), `PENDING` (ready to submit runs), `SUBMITTING` (submitting runs),
    /// `INPROGRESS` (runs executing), `STOPPING` (cancellation in progress),
    /// `PROCESSED` (all runs completed), `CANCELLED` (batch cancelled), `FAILED`
    /// (batch failed), `RUNS_DELETING` (deleting runs), `RUNS_DELETE_FAILED` (run
    /// deletion failed for some or all runs), `RUNS_DELETED` (runs deleted).
    status: ?BatchStatus = null,

    /// A summary of run submission outcomes. See `SubmissionSummary`.
    submission_summary: ?SubmissionSummary = null,

    /// The timestamp when all run submissions completed.
    submitted_time: ?i64 = null,

    /// Amazon Web Services tags associated with the run batch.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total number of runs in the batch.
    total_runs: ?i32 = null,

    /// The universally unique identifier (UUID) for the run batch.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .default_run_setting = "defaultRunSetting",
        .failed_time = "failedTime",
        .failure_reason = "failureReason",
        .id = "id",
        .name = "name",
        .processed_time = "processedTime",
        .run_summary = "runSummary",
        .status = "status",
        .submission_summary = "submissionSummary",
        .submitted_time = "submittedTime",
        .tags = "tags",
        .total_runs = "totalRuns",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchInput, options: CallOptions) !GetBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runBatch/");
    try path_buf.appendSlice(allocator, input.batch_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchOutput {
    const result: GetBatchOutput = try aws.json.parseJsonObject(
        GetBatchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
