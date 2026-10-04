const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;
const KnowledgeBase = @import("knowledge_base.zig").KnowledgeBase;

pub const UpdateKnowledgeBaseInput = struct {
    /// Specifies a new description for the knowledge base.
    description: ?[]const u8 = null,

    /// Specifies the configuration for the embeddings model used for the knowledge
    /// base. You must use the same configuration as when the knowledge base was
    /// created.
    knowledge_base_configuration: KnowledgeBaseConfiguration,

    /// The unique identifier of the knowledge base to update.
    knowledge_base_id: []const u8,

    /// Specifies a new name for the knowledge base.
    name: []const u8,

    /// Specifies a different Amazon Resource Name (ARN) of the IAM role with
    /// permissions to invoke API operations on the knowledge base.
    role_arn: []const u8,

    /// Specifies the configuration for the vector store used for the knowledge
    /// base. You must use the same configuration as when the knowledge base was
    /// created.
    storage_configuration: ?StorageConfiguration = null,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_configuration = "knowledgeBaseConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .role_arn = "roleArn",
        .storage_configuration = "storageConfiguration",
    };
};

pub const UpdateKnowledgeBaseOutput = struct {
    /// Contains details about the knowledge base.
    knowledge_base: ?KnowledgeBase = null,

    pub const json_field_names = .{
        .knowledge_base = "knowledgeBase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKnowledgeBaseInput, options: CallOptions) !UpdateKnowledgeBaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"knowledgeBaseConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.knowledge_base_configuration), input.knowledge_base_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.storage_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKnowledgeBaseOutput {
    const result: UpdateKnowledgeBaseOutput = try aws.json.parseJsonObject(
        UpdateKnowledgeBaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
