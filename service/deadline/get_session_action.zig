const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcquiredLimit = @import("acquired_limit.zig").AcquiredLimit;
const SessionActionDefinition = @import("session_action_definition.zig").SessionActionDefinition;
const TaskRunManifestPropertiesResponse = @import("task_run_manifest_properties_response.zig").TaskRunManifestPropertiesResponse;
const SessionActionStatus = @import("session_action_status.zig").SessionActionStatus;

pub const GetSessionActionInput = struct {
    /// The farm ID for the session action.
    farm_id: []const u8,

    /// The job ID for the session.
    job_id: []const u8,

    /// The queue ID for the session action.
    queue_id: []const u8,

    /// The session action ID for the session.
    session_action_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .session_action_id = "sessionActionId",
    };
};

pub const GetSessionActionOutput = struct {
    /// The limits and their amounts acquired during a session action. If no limits
    /// were acquired during the session, this field isn't returned.
    acquired_limits: ?[]const AcquiredLimit = null,

    /// The session action definition.
    definition: ?SessionActionDefinition = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The list of manifest properties that describe file attachments for the task
    /// run.
    manifests: ?[]const TaskRunManifestPropertiesResponse = null,

    /// The process exit code. The default Deadline Cloud worker agent converts
    /// unsigned 32-bit exit codes to signed 32-bit exit codes.
    process_exit_code: ?i32 = null,

    /// The message that communicates the progress of the session action.
    progress_message: ?[]const u8 = null,

    /// The percentage completed for a session action.
    progress_percent: ?f32 = null,

    /// The session action ID.
    session_action_id: []const u8,

    /// The session ID for the session action.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The status of the session action.
    status: SessionActionStatus,

    /// The Linux timestamp of the date and time the session action was last
    /// updated.
    worker_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acquired_limits = "acquiredLimits",
        .definition = "definition",
        .ended_at = "endedAt",
        .manifests = "manifests",
        .process_exit_code = "processExitCode",
        .progress_message = "progressMessage",
        .progress_percent = "progressPercent",
        .session_action_id = "sessionActionId",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .status = "status",
        .worker_updated_at = "workerUpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionActionInput, options: CallOptions) !GetSessionActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/session-actions/");
    try path_buf.appendSlice(allocator, input.session_action_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionActionOutput {
    var result: GetSessionActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSessionActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
