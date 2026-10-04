const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceExecutionStatus = @import("inference_execution_status.zig").InferenceExecutionStatus;
const InferenceExecutionSummary = @import("inference_execution_summary.zig").InferenceExecutionSummary;

pub const ListInferenceExecutionsInput = struct {
    /// The time reference in the inferenced dataset before which Amazon Lookout for
    /// Equipment stopped the
    /// inference execution.
    data_end_time_before: ?i64 = null,

    /// The time reference in the inferenced dataset after which Amazon Lookout for
    /// Equipment started the inference
    /// execution.
    data_start_time_after: ?i64 = null,

    /// The name of the inference scheduler for the inference execution listed.
    inference_scheduler_name: []const u8,

    /// Specifies the maximum number of inference executions to list.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// executions.
    next_token: ?[]const u8 = null,

    /// The status of the inference execution.
    status: ?InferenceExecutionStatus = null,

    pub const json_field_names = .{
        .data_end_time_before = "DataEndTimeBefore",
        .data_start_time_after = "DataStartTimeAfter",
        .inference_scheduler_name = "InferenceSchedulerName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListInferenceExecutionsOutput = struct {
    /// Provides an array of information about the individual inference executions
    /// returned from
    /// the `ListInferenceExecutions` operation, including model used, inference
    /// scheduler, data configuration, and so on.
    ///
    /// If you don't supply the `InferenceSchedulerName` request parameter, or
    /// if you supply the name of an inference scheduler that doesn't exist,
    /// `ListInferenceExecutions` returns an empty array in
    /// `InferenceExecutionSummaries`.
    inference_execution_summaries: ?[]const InferenceExecutionSummary = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// executions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_execution_summaries = "InferenceExecutionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceExecutionsInput, options: CallOptions) !ListInferenceExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListInferenceExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceExecutionsOutput, body, allocator);
}
