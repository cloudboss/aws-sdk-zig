const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeedbackCategory = @import("feedback_category.zig").FeedbackCategory;
const RecommendationFeedbackType = @import("recommendation_feedback_type.zig").RecommendationFeedbackType;

pub const PutAgentRecommendationFeedbackInput = struct {
    /// Optional comments providing additional context about the feedback.
    comments: ?[]const u8 = null,

    /// Optional category classifying the nature of the feedback.
    feedback_category: ?FeedbackCategory = null,

    /// The Amazon Resource Name (ARN) of the recommendation to provide feedback
    /// for.
    recommendation_arn: []const u8,

    /// The type of feedback being provided.
    @"type": RecommendationFeedbackType,

    pub const json_field_names = .{
        .comments = "comments",
        .feedback_category = "feedbackCategory",
        .recommendation_arn = "recommendationArn",
        .@"type" = "type",
    };
};

pub const PutAgentRecommendationFeedbackOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAgentRecommendationFeedbackInput, options: CallOptions) !PutAgentRecommendationFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAgentRecommendationFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/agent-recommendations/");
    try path_buf.appendSlice(allocator, input.recommendation_arn);
    try path_buf.appendSlice(allocator, "/feedback");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.feedback_category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"feedbackCategory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAgentRecommendationFeedbackOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutAgentRecommendationFeedbackOutput = .{};

    return result;
}
