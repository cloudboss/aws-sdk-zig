const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseType = @import("knowledge_base_type.zig").KnowledgeBaseType;
const RenderingConfiguration = @import("rendering_configuration.zig").RenderingConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const VectorIngestionConfiguration = @import("vector_ingestion_configuration.zig").VectorIngestionConfiguration;
const KnowledgeBaseData = @import("knowledge_base_data.zig").KnowledgeBaseData;

pub const CreateKnowledgeBaseInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the Amazon Web Services SDK
    /// populates this field. For more information about idempotency, see [Making
    /// retries safe with idempotent
    /// APIs](http://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The description.
    description: ?[]const u8 = null,

    /// The type of knowledge base. Only CUSTOM knowledge bases allow you to upload
    /// your own content. EXTERNAL knowledge bases support integrations with
    /// third-party systems whose content is synchronized automatically.
    knowledge_base_type: KnowledgeBaseType,

    /// The name of the knowledge base.
    name: []const u8,

    /// Information about how to render the content.
    rendering_configuration: ?RenderingConfiguration = null,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, `kms:Decrypt`, and `kms:GenerateDataKey*` permissions to
    /// the IAM identity using the key to invoke Amazon Q in Connect.
    ///
    /// For more information about setting up a customer managed key for Amazon Q in
    /// Connect, see [Enable Amazon Q in Connect for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-q.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The source of the knowledge base content. Only set this argument for
    /// EXTERNAL or Managed knowledge bases.
    source_configuration: ?SourceConfiguration = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Contains details about how to ingest the documents in a data source.
    vector_ingestion_configuration: ?VectorIngestionConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .knowledge_base_type = "knowledgeBaseType",
        .name = "name",
        .rendering_configuration = "renderingConfiguration",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .source_configuration = "sourceConfiguration",
        .tags = "tags",
        .vector_ingestion_configuration = "vectorIngestionConfiguration",
    };
};

pub const CreateKnowledgeBaseOutput = struct {
    /// The knowledge base.
    knowledge_base: ?KnowledgeBaseData = null,

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/knowledgeBases";

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
    try body_buf.appendSlice(allocator, "\"knowledgeBaseType\":");
    try aws.json.writeValue(@TypeOf(input.knowledge_base_type), input.knowledge_base_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.rendering_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"renderingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.server_side_encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverSideEncryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vector_ingestion_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vectorIngestionConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKnowledgeBaseOutput {
    const result: CreateKnowledgeBaseOutput = try aws.json.parseJsonObject(
        CreateKnowledgeBaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
