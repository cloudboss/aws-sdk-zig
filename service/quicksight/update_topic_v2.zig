const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomInstructions = @import("custom_instructions.zig").CustomInstructions;
const TopicV2PublishOption = @import("topic_v2_publish_option.zig").TopicV2PublishOption;
const TopicV2Details = @import("topic_v2_details.zig").TopicV2Details;

pub const UpdateTopicV2Input = struct {
    /// The ID of the Amazon Web Services account that contains the topic that you
    /// want to
    /// update.
    aws_account_id: []const u8,

    custom_instructions: ?CustomInstructions = null,

    /// The publish option for the topic that you want to update.
    publish_option: ?TopicV2PublishOption = null,

    /// The definition of the topic that you want to update.
    topic: TopicV2Details,

    /// The ID of the topic that you want to modify. This ID is unique per Amazon
    /// Web Services Region for each Amazon Web Services account.
    topic_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .custom_instructions = "CustomInstructions",
        .publish_option = "PublishOption",
        .topic = "Topic",
        .topic_id = "TopicId",
    };
};

pub const UpdateTopicV2Output = struct {
    /// The Amazon Resource Name (ARN) of the topic.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ID of the topic that you want to modify. This ID is unique per Amazon
    /// Web Services Region for each Amazon Web Services account.
    topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .request_id = "RequestId",
        .status = "Status",
        .topic_id = "TopicId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTopicV2Input, options: CallOptions) !UpdateTopicV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTopicV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/topicsV2/");
    try path_buf.appendSlice(allocator, input.topic_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.custom_instructions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomInstructions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.publish_option) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PublishOption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Topic\":");
    try aws.json.writeValue(@TypeOf(input.topic), input.topic, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTopicV2Output {
    var result: UpdateTopicV2Output = try aws.json.parseJsonObject(
        UpdateTopicV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
