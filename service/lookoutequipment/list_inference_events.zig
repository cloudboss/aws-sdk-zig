const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceEventSummary = @import("inference_event_summary.zig").InferenceEventSummary;

pub const ListInferenceEventsInput = struct {
    /// The name of the inference scheduler for the inference events listed.
    inference_scheduler_name: []const u8,

    /// Returns all the inference events with an end start time equal to or greater
    /// than less
    /// than the end time given.
    interval_end_time: i64,

    /// Lookout for Equipment will return all the inference events with an end time
    /// equal to or greater than
    /// the start time given.
    interval_start_time: i64,

    /// Specifies the maximum number of inference events to list.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// events.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_scheduler_name = "InferenceSchedulerName",
        .interval_end_time = "IntervalEndTime",
        .interval_start_time = "IntervalStartTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListInferenceEventsOutput = struct {
    /// Provides an array of information about the individual inference events
    /// returned from the
    /// `ListInferenceEvents` operation, including scheduler used, event start time,
    /// event end time, diagnostics, and so on.
    inference_event_summaries: ?[]const InferenceEventSummary = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// executions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_event_summaries = "InferenceEventSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceEventsInput, options: CallOptions) !ListInferenceEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceEventsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListInferenceEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceEventsOutput, body, allocator);
}
