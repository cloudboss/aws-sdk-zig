const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeactivateMessageTemplateInput = struct {
    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The identifier of the message template. Can be either the ID or the ARN. It
    /// cannot contain any qualifier.
    message_template_id: []const u8,

    /// The version number of the message template version to deactivate.
    version_number: i64,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .message_template_id = "messageTemplateId",
        .version_number = "versionNumber",
    };
};

pub const DeactivateMessageTemplateOutput = struct {
    /// The Amazon Resource Name (ARN) of the message template.
    message_template_arn: []const u8,

    /// The identifier of the message template.
    message_template_id: []const u8,

    /// The version number of the message template version that has been
    /// deactivated.
    version_number: i64,

    pub const json_field_names = .{
        .message_template_arn = "messageTemplateArn",
        .message_template_id = "messageTemplateId",
        .version_number = "versionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeactivateMessageTemplateInput, options: CallOptions) !DeactivateMessageTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeactivateMessageTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/messageTemplates/");
    try path_buf.appendSlice(allocator, input.message_template_id);
    try path_buf.appendSlice(allocator, "/deactivate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"versionNumber\":");
    try aws.json.writeValue(@TypeOf(input.version_number), input.version_number, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeactivateMessageTemplateOutput {
    var result: DeactivateMessageTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeactivateMessageTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
