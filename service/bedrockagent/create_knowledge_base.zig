const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;
const KnowledgeBase = @import("knowledge_base.zig").KnowledgeBase;

pub const CreateKnowledgeBaseInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description of the knowledge base.
    description: ?[]const u8 = null,

    /// Contains details about the embeddings model used for the knowledge base.
    knowledge_base_configuration: KnowledgeBaseConfiguration,

    /// A name for the knowledge base.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to invoke
    /// API operations on the knowledge base.
    role_arn: []const u8,

    /// Contains details about the configuration of the vector database used for the
    /// knowledge base.
    storage_configuration: ?StorageConfiguration = null,

    /// Specify the key-value pairs for the tags that you want to attach to your
    /// knowledge base in this object.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .knowledge_base_configuration = "knowledgeBaseConfiguration",
        .name = "name",
        .role_arn = "roleArn",
        .storage_configuration = "storageConfiguration",
        .tags = "tags",
    };
};

pub const CreateKnowledgeBaseOutput = struct {
    /// Contains details about the knowledge base.
    knowledge_base: ?KnowledgeBase = null,

    pub const json_field_names = .{
        .knowledge_base = "knowledgeBase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKnowledgeBaseInput, options: CallOptions) !CreateKnowledgeBaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/knowledgebases/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKnowledgeBaseOutput {
    var result: CreateKnowledgeBaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateKnowledgeBaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
