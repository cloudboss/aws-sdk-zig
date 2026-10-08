const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeedbackType = @import("feedback_type.zig").FeedbackType;

pub const SubmitFeedbackInput = struct {
    /// The universally unique identifier (UUID) of the
    /// [
    /// `AnomalyInstance`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_AnomalyInstance.html) object
    /// that is included in the analysis data.
    anomaly_instance_id: []const u8,

    /// Optional feedback about this anomaly.
    comment: ?[]const u8 = null,

    /// The name of the profiling group that is associated with the analysis data.
    profiling_group_name: []const u8,

    /// The feedback tpye. Thee are two valid values, `Positive` and `Negative`.
    type: FeedbackType,

    pub const json_field_names = .{
        .anomaly_instance_id = "anomalyInstanceId",
        .comment = "comment",
        .profiling_group_name = "profilingGroupName",
        .type = "type",
    };
};

pub const SubmitFeedbackOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitFeedbackInput, options: CallOptions) !SubmitFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/internal/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/anomalies/");
    try path_buf.appendSlice(allocator, input.anomaly_instance_id);
    try path_buf.appendSlice(allocator, "/feedback");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitFeedbackOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SubmitFeedbackOutput = .{};

    return result;
}
