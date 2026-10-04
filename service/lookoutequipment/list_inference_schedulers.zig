const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceSchedulerStatus = @import("inference_scheduler_status.zig").InferenceSchedulerStatus;
const InferenceSchedulerSummary = @import("inference_scheduler_summary.zig").InferenceSchedulerSummary;

pub const ListInferenceSchedulersInput = struct {
    /// The beginning of the name of the inference schedulers to be listed.
    inference_scheduler_name_begins_with: ?[]const u8 = null,

    /// Specifies the maximum number of inference schedulers to list.
    max_results: ?i32 = null,

    /// The name of the machine learning model used by the inference scheduler to be
    /// listed.
    model_name: ?[]const u8 = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// schedulers.
    next_token: ?[]const u8 = null,

    /// Specifies the current status of the inference schedulers.
    status: ?InferenceSchedulerStatus = null,

    pub const json_field_names = .{
        .inference_scheduler_name_begins_with = "InferenceSchedulerNameBeginsWith",
        .max_results = "MaxResults",
        .model_name = "ModelName",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListInferenceSchedulersOutput = struct {
    /// Provides information about the specified inference scheduler, including data
    /// upload
    /// frequency, model name and ARN, and status.
    inference_scheduler_summaries: ?[]const InferenceSchedulerSummary = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// inference
    /// schedulers.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_scheduler_summaries = "InferenceSchedulerSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceSchedulersInput, options: CallOptions) !ListInferenceSchedulersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceSchedulersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListInferenceSchedulers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceSchedulersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceSchedulersOutput, body, allocator);
}
