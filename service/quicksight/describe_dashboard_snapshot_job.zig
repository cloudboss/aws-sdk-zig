const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotJobStatus = @import("snapshot_job_status.zig").SnapshotJobStatus;
const SnapshotConfiguration = @import("snapshot_configuration.zig").SnapshotConfiguration;
const SnapshotUserConfigurationRedacted = @import("snapshot_user_configuration_redacted.zig").SnapshotUserConfigurationRedacted;

pub const DescribeDashboardSnapshotJobInput = struct {
    /// The ID of the Amazon Web Services account that the dashboard snapshot job is
    /// executed in.
    aws_account_id: []const u8,

    /// The ID of the dashboard that you have started a snapshot job for.
    dashboard_id: []const u8,

    /// The ID of the job to be described. The job ID is set when you start a new
    /// job with a `StartDashboardSnapshotJob` API call.
    snapshot_job_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .snapshot_job_id = "SnapshotJobId",
    };
};

pub const DescribeDashboardSnapshotJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the snapshot job. The job ARN is
    /// generated when you start a new job with a `StartDashboardSnapshotJob` API
    /// call.
    arn: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that the dashboard snapshot job is
    /// executed in.
    aws_account_id: ?[]const u8 = null,

    /// The time that the snapshot job was created.
    created_time: ?i64 = null,

    /// The ID of the dashboard that you have started a snapshot job for.
    dashboard_id: ?[]const u8 = null,

    /// Indicates the status of a job. The status updates as the job executes. This
    /// shows one of the following values.
    ///
    /// * `COMPLETED` - The job was completed successfully.
    ///
    /// * `FAILED` - The job failed to execute.
    ///
    /// * `QUEUED` - The job is queued and hasn't started yet.
    ///
    /// * `RUNNING` - The job is still running.
    job_status: ?SnapshotJobStatus = null,

    /// The time that the snapshot job status was last updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The snapshot configuration of the job. This information is provided when you
    /// make a `StartDashboardSnapshotJob` API call.
    snapshot_configuration: ?SnapshotConfiguration = null,

    /// The ID of the job to be described. The job ID is set when you start a new
    /// job with a `StartDashboardSnapshotJob` API call.
    snapshot_job_id: ?[]const u8 = null,

    /// The HTTP status of the request
    status: ?i32 = null,

    /// The user configuration for the snapshot job. This information is provided
    /// when you make a `StartDashboardSnapshotJob` API call.
    user_configuration: ?SnapshotUserConfigurationRedacted = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_account_id = "AwsAccountId",
        .created_time = "CreatedTime",
        .dashboard_id = "DashboardId",
        .job_status = "JobStatus",
        .last_updated_time = "LastUpdatedTime",
        .request_id = "RequestId",
        .snapshot_configuration = "SnapshotConfiguration",
        .snapshot_job_id = "SnapshotJobId",
        .status = "Status",
        .user_configuration = "UserConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDashboardSnapshotJobInput, options: CallOptions) !DescribeDashboardSnapshotJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDashboardSnapshotJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/snapshot-jobs/");
    try path_buf.appendSlice(allocator, input.snapshot_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDashboardSnapshotJobOutput {
    const result: DescribeDashboardSnapshotJobOutput = try aws.json.parseJsonObject(
        DescribeDashboardSnapshotJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
