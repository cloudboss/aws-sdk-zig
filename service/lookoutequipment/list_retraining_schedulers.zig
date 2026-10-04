const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrainingSchedulerStatus = @import("retraining_scheduler_status.zig").RetrainingSchedulerStatus;
const RetrainingSchedulerSummary = @import("retraining_scheduler_summary.zig").RetrainingSchedulerSummary;

pub const ListRetrainingSchedulersInput = struct {
    /// Specifies the maximum number of retraining schedulers to list.
    max_results: ?i32 = null,

    /// Specify this field to only list retraining schedulers whose machine learning
    /// models
    /// begin with the value you specify.
    model_name_begins_with: ?[]const u8 = null,

    /// If the number of results exceeds the maximum, a pagination token is
    /// returned. Use the
    /// token in the request to show the next page of retraining schedulers.
    next_token: ?[]const u8 = null,

    /// Specify this field to only list retraining schedulers whose status matches
    /// the value you
    /// specify.
    status: ?RetrainingSchedulerStatus = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .model_name_begins_with = "ModelNameBeginsWith",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListRetrainingSchedulersOutput = struct {
    /// If the number of results exceeds the maximum, this pagination token is
    /// returned. Use
    /// this token in the request to show the next page of retraining schedulers.
    next_token: ?[]const u8 = null,

    /// Provides information on the specified retraining scheduler, including the
    /// model name,
    /// model ARN, status, and start date.
    retraining_scheduler_summaries: ?[]const RetrainingSchedulerSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .retraining_scheduler_summaries = "RetrainingSchedulerSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRetrainingSchedulersInput, options: CallOptions) !ListRetrainingSchedulersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRetrainingSchedulersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListRetrainingSchedulers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRetrainingSchedulersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRetrainingSchedulersOutput, body, allocator);
}
