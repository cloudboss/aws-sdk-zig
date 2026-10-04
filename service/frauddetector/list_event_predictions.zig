const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterCondition = @import("filter_condition.zig").FilterCondition;
const PredictionTimeRange = @import("prediction_time_range.zig").PredictionTimeRange;
const EventPredictionSummary = @import("event_prediction_summary.zig").EventPredictionSummary;

pub const ListEventPredictionsInput = struct {
    /// The detector ID.
    detector_id: ?FilterCondition = null,

    /// The detector version ID.
    detector_version_id: ?FilterCondition = null,

    /// The event ID.
    event_id: ?FilterCondition = null,

    /// The event type associated with the detector.
    event_type: ?FilterCondition = null,

    /// The maximum number of predictions to return for the request.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return. Use the token to make the
    /// call again to retrieve the next page. Keep all other arguments unchanged.
    /// Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    /// The time period for when the predictions were generated.
    prediction_time_range: ?PredictionTimeRange = null,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .event_id = "eventId",
        .event_type = "eventType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .prediction_time_range = "predictionTimeRange",
    };
};

pub const ListEventPredictionsOutput = struct {
    /// The summary of the past predictions.
    event_prediction_summaries: ?[]const EventPredictionSummary = null,

    /// Identifies the next page of results to return. Use the token to make the
    /// call again to retrieve the next page. Keep all other arguments unchanged.
    /// Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_prediction_summaries = "eventPredictionSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEventPredictionsInput, options: CallOptions) !ListEventPredictionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEventPredictionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.ListEventPredictions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEventPredictionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEventPredictionsOutput, body, allocator);
}
