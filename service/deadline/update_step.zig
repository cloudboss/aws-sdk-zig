const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepTargetTaskRunStatus = @import("step_target_task_run_status.zig").StepTargetTaskRunStatus;

pub const UpdateStepInput = struct {
    /// The unique token which the server uses to recognize retries of the same
    /// request.
    client_token: ?[]const u8 = null,

    /// The farm ID to update.
    farm_id: []const u8,

    /// The job ID to update.
    job_id: []const u8,

    /// The queue ID to update.
    queue_id: []const u8,

    /// The step ID to update.
    step_id: []const u8,

    /// The task status to update the step's tasks to.
    target_task_run_status: StepTargetTaskRunStatus,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
        .target_task_run_status = "targetTaskRunStatus",
    };
};

pub const UpdateStepOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStepInput, options: CallOptions) !UpdateStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/steps/");
    try path_buf.appendSlice(allocator, input.step_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetTaskRunStatus\":");
    try aws.json.writeValue(@TypeOf(input.target_task_run_status), input.target_task_run_status, allocator, &body_buf);
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
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amz-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStepOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateStepOutput = .{};

    return result;
}
