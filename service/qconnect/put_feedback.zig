const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentFeedbackData = @import("content_feedback_data.zig").ContentFeedbackData;
const TargetType = @import("target_type.zig").TargetType;

pub const PutFeedbackInput = struct {
    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// Information about the feedback provided.
    content_feedback: ContentFeedbackData,

    /// The identifier of the feedback target.
    target_id: []const u8,

    /// The type of the feedback target.
    target_type: TargetType,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .content_feedback = "contentFeedback",
        .target_id = "targetId",
        .target_type = "targetType",
    };
};

pub const PutFeedbackOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// Information about the feedback provided.
    content_feedback: ?ContentFeedbackData = null,

    /// The identifier of the feedback target.
    target_id: []const u8,

    /// The type of the feedback target.
    target_type: TargetType,

    pub const json_field_names = .{
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .content_feedback = "contentFeedback",
        .target_id = "targetId",
        .target_type = "targetType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutFeedbackInput, options: CallOptions) !PutFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/feedback");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentFeedback\":");
    try aws.json.writeValue(@TypeOf(input.content_feedback), input.content_feedback, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetId\":");
    try aws.json.writeValue(@TypeOf(input.target_id), input.target_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetType\":");
    try aws.json.writeValue(@TypeOf(input.target_type), input.target_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutFeedbackOutput {
    const result: PutFeedbackOutput = try aws.json.parseJsonObject(
        PutFeedbackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
