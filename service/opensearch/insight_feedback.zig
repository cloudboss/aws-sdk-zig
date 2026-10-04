const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightFeedbackEntity = @import("insight_feedback_entity.zig").InsightFeedbackEntity;
const InsightFeedbackThumbs = @import("insight_feedback_thumbs.zig").InsightFeedbackThumbs;
const InsightResponseStatus = @import("insight_response_status.zig").InsightResponseStatus;

pub const InsightFeedbackInput = struct {
    /// The entity for which to submit insight feedback. Specifies the type and
    /// value of the
    /// entity, such as a domain name.
    entity: InsightFeedbackEntity,

    /// Optional text feedback providing additional details about the insight.
    /// Maximum length
    /// is 1000 characters.
    feedback_text: ?[]const u8 = null,

    /// The unique identifier of the insight for which to submit feedback.
    insight_id: []const u8,

    /// The thumbs up or thumbs down feedback for the insight. Possible values are
    /// `Up` and `Down`.
    thumbs: InsightFeedbackThumbs,

    pub const json_field_names = .{
        .entity = "Entity",
        .feedback_text = "FeedbackText",
        .insight_id = "InsightId",
        .thumbs = "Thumbs",
    };
};

pub const InsightFeedbackOutput = struct {
    /// The status of the feedback submission. Possible values are `SUCCESS` and
    /// `ERROR`.
    status: ?InsightResponseStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InsightFeedbackInput, options: CallOptions) !InsightFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InsightFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/insight-feedback";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Entity\":");
    try aws.json.writeValue(@TypeOf(input.entity), input.entity, allocator, &body_buf);
    has_prev = true;
    if (input.feedback_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FeedbackText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InsightId\":");
    try aws.json.writeValue(@TypeOf(input.insight_id), input.insight_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Thumbs\":");
    try aws.json.writeValue(@TypeOf(input.thumbs), input.thumbs, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InsightFeedbackOutput {
    const result: InsightFeedbackOutput = try aws.json.parseJsonObject(
        InsightFeedbackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
