const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIPromptAPIFormat = @import("ai_prompt_api_format.zig").AIPromptAPIFormat;
const AIPromptInferenceConfiguration = @import("ai_prompt_inference_configuration.zig").AIPromptInferenceConfiguration;
const AIPromptTemplateConfiguration = @import("ai_prompt_template_configuration.zig").AIPromptTemplateConfiguration;
const AIPromptTemplateType = @import("ai_prompt_template_type.zig").AIPromptTemplateType;
const AIPromptType = @import("ai_prompt_type.zig").AIPromptType;
const VisibilityStatus = @import("visibility_status.zig").VisibilityStatus;
const AIPromptData = @import("ai_prompt_data.zig").AIPromptData;

pub const CreateAIPromptInput = struct {
    /// The API Format of the AI Prompt.
    ///
    /// Recommended values: `MESSAGES | TEXT_COMPLETIONS`
    ///
    /// The values `ANTHROPIC_CLAUDE_MESSAGES | ANTHROPIC_CLAUDE_TEXT_COMPLETIONS`
    /// will be deprecated.
    api_format: AIPromptAPIFormat,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the Amazon Web Services SDK
    /// populates this field. For more information about idempotency, see [Making
    /// retries safe with idempotent
    /// APIs](http://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/)..
    client_token: ?[]const u8 = null,

    /// The description of the AI Prompt.
    description: ?[]const u8 = null,

    /// The inference configuration for the AI Prompt being created.
    inference_configuration: ?AIPromptInferenceConfiguration = null,

    /// The identifier of the model used for this AI Prompt.
    ///
    /// For information about which models are supported in each Amazon Web Services
    /// Region, see [Supported models for system/custom
    /// prompts](https://docs.aws.amazon.com/connect/latest/adminguide/create-ai-prompts.html#cli-create-aiprompt).
    model_id: []const u8,

    /// The name of the AI Prompt.
    name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration of the prompt template for this AI Prompt.
    template_configuration: AIPromptTemplateConfiguration,

    /// The type of the prompt template for this AI Prompt.
    template_type: AIPromptTemplateType,

    /// The type of this AI Prompt.
    @"type": AIPromptType,

    /// The visibility status of the AI Prompt.
    visibility_status: VisibilityStatus,

    pub const json_field_names = .{
        .api_format = "apiFormat",
        .assistant_id = "assistantId",
        .client_token = "clientToken",
        .description = "description",
        .inference_configuration = "inferenceConfiguration",
        .model_id = "modelId",
        .name = "name",
        .tags = "tags",
        .template_configuration = "templateConfiguration",
        .template_type = "templateType",
        .@"type" = "type",
        .visibility_status = "visibilityStatus",
    };
};

pub const CreateAIPromptOutput = struct {
    /// The data of the AI Prompt.
    ai_prompt: ?AIPromptData = null,

    pub const json_field_names = .{
        .ai_prompt = "aiPrompt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAIPromptInput, options: CallOptions) !CreateAIPromptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAIPromptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/aiprompts");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"apiFormat\":");
    try aws.json.writeValue(@TypeOf(input.api_format), input.api_format, allocator, &body_buf);
    has_prev = true;
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
    if (input.inference_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inferenceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelId\":");
    try aws.json.writeValue(@TypeOf(input.model_id), input.model_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.template_configuration), input.template_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateType\":");
    try aws.json.writeValue(@TypeOf(input.template_type), input.template_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"visibilityStatus\":");
    try aws.json.writeValue(@TypeOf(input.visibility_status), input.visibility_status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAIPromptOutput {
    const result: CreateAIPromptOutput = try aws.json.parseJsonObject(
        CreateAIPromptOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
