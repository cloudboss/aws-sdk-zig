const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FrontOfQueueDetail = @import("front_of_queue_detail.zig").FrontOfQueueDetail;
const FrontOfQuotaSharesDetail = @import("front_of_quota_shares_detail.zig").FrontOfQuotaSharesDetail;
const QueueSnapshotUtilizationDetail = @import("queue_snapshot_utilization_detail.zig").QueueSnapshotUtilizationDetail;

pub const GetJobQueueSnapshotInput = struct {
    /// The job queue’s name or full queue Amazon Resource Name (ARN).
    job_queue: []const u8,

    pub const json_field_names = .{
        .job_queue = "jobQueue",
    };
};

pub const GetJobQueueSnapshotOutput = struct {
    /// The list of the first 100 `RUNNABLE` jobs in each job queue. For
    /// first-in-first-out (FIFO) job queues, jobs are ordered based on their
    /// submission time. For job queues with an attached
    /// fair-share scheduling (FSS) or quota-share policy, jobs are ordered based on
    /// their job priority and share
    /// usage.
    front_of_queue: ?FrontOfQueueDetail = null,

    /// The first `RUNNABLE` job in each quota share. Jobs are ordered based on
    /// their job priority and share usage.
    front_of_quota_shares: ?FrontOfQuotaSharesDetail = null,

    /// The job queue's capacity utilization, including total usage and
    /// breakdown per given share.
    queue_utilization: ?QueueSnapshotUtilizationDetail = null,

    pub const json_field_names = .{
        .front_of_queue = "frontOfQueue",
        .front_of_quota_shares = "frontOfQuotaShares",
        .queue_utilization = "queueUtilization",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobQueueSnapshotInput, options: CallOptions) !GetJobQueueSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobQueueSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/getjobqueuesnapshot";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobQueue\":");
    try aws.json.writeValue(@TypeOf(input.job_queue), input.job_queue, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobQueueSnapshotOutput {
    var result: GetJobQueueSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetJobQueueSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
