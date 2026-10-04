const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClickFeedback = @import("click_feedback.zig").ClickFeedback;
const RelevanceFeedback = @import("relevance_feedback.zig").RelevanceFeedback;

pub const SubmitFeedbackInput = struct {
    /// Tells Amazon Kendra that a particular search result link was chosen
    /// by the user.
    click_feedback_items: ?[]const ClickFeedback = null,

    /// The identifier of the index that was queried.
    index_id: []const u8,

    /// The identifier of the specific query for which you are submitting
    /// feedback. The query ID is returned in the response to the
    /// `Query` API.
    query_id: []const u8,

    /// Provides Amazon Kendra with relevant or not relevant feedback for
    /// whether a particular item was relevant to the search.
    relevance_feedback_items: ?[]const RelevanceFeedback = null,

    pub const json_field_names = .{
        .click_feedback_items = "ClickFeedbackItems",
        .index_id = "IndexId",
        .query_id = "QueryId",
        .relevance_feedback_items = "RelevanceFeedbackItems",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.SubmitFeedback");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitFeedbackOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
