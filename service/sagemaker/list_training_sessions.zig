const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainingSessionStatus = @import("training_session_status.zig").TrainingSessionStatus;
const TrainingSessionSummary = @import("training_session_summary.zig").TrainingSessionSummary;

pub const ListTrainingSessionsInput = struct {
    /// A filter that returns only training sessions created after the specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only training sessions created before the specified
    /// time.
    creation_time_before: ?i64 = null,

    /// The maximum number of training sessions to return in the response.
    max_results: ?i32 = null,

    /// A string in the training session name to filter results. Only sessions whose
    /// name contains the specified string are returned.
    name_contains: ?[]const u8 = null,

    /// If the response was truncated, use the token returned in the previous
    /// response to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// A filter that returns only training sessions with the specified status.
    status_equals: ?TrainingSessionStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .status_equals = "StatusEquals",
    };
};

pub const ListTrainingSessionsOutput = struct {
    /// If the response is truncated, this token retrieves the next set of results.
    next_token: ?[]const u8 = null,

    /// An array of `TrainingSessionSummary` objects that provide summary
    /// information about the training sessions.
    training_session_summaries: ?[]const TrainingSessionSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .training_session_summaries = "TrainingSessionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainingSessionsInput, options: CallOptions) !ListTrainingSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainingSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrainingSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainingSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTrainingSessionsOutput, body, allocator);
}
