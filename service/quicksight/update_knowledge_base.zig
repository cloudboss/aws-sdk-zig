const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessControlConfiguration = @import("access_control_configuration.zig").AccessControlConfiguration;
const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;

pub const UpdateKnowledgeBaseInput = struct {
    /// The access control configuration for the knowledge base. If you don't
    /// specify this parameter, the existing setting is retained.
    access_control_configuration: ?AccessControlConfiguration = null,

    /// The ID of the Amazon Web Services account that contains the knowledge base.
    aws_account_id: []const u8,

    /// A description for the knowledge base. If you don't specify a description,
    /// the existing description is retained.
    description: ?[]const u8 = null,

    /// Specifies whether email notifications are enabled for ingestion failures.
    is_email_notification_opted_for_ingestion_failures: ?bool = null,

    knowledge_base_configuration: ?KnowledgeBaseConfiguration = null,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The name of the knowledge base. If you don't specify a name, the existing
    /// name is retained.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_configuration = "AccessControlConfiguration",
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .is_email_notification_opted_for_ingestion_failures = "IsEmailNotificationOptedForIngestionFailures",
        .knowledge_base_configuration = "KnowledgeBaseConfiguration",
        .knowledge_base_id = "KnowledgeBaseId",
        .media_extraction_configuration = "MediaExtractionConfiguration",
        .name = "Name",
    };
};

pub const UpdateKnowledgeBaseOutput = struct {
    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .knowledge_base_arn = "KnowledgeBaseArn",
        .knowledge_base_id = "KnowledgeBaseId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKnowledgeBaseInput, options: CallOptions) !UpdateKnowledgeBaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/knowledge-bases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_control_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessControlConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_email_notification_opted_for_ingestion_failures) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsEmailNotificationOptedForIngestionFailures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.knowledge_base_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KnowledgeBaseConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_extraction_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaExtractionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKnowledgeBaseOutput {
    var result: UpdateKnowledgeBaseOutput = try aws.json.parseJsonObject(
        UpdateKnowledgeBaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
