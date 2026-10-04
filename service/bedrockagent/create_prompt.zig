const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PromptVariant = @import("prompt_variant.zig").PromptVariant;

pub const CreatePromptInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key to encrypt the prompt.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The name of the default variant for the prompt. This value must match the
    /// `name` field in the relevant
    /// [PromptVariant](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptVariant.html) object.
    default_variant: ?[]const u8 = null,

    /// A description for the prompt.
    description: ?[]const u8 = null,

    /// A name for the prompt.
    name: []const u8,

    /// Any tags that you want to attach to the prompt. For more information, see
    /// [Tagging resources in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of objects, each containing details about a variant of the prompt.
    variants: ?[]const PromptVariant = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .default_variant = "defaultVariant",
        .description = "description",
        .name = "name",
        .tags = "tags",
        .variants = "variants",
    };
};

pub const CreatePromptOutput = struct {
    /// The Amazon Resource Name (ARN) of the prompt.
    arn: []const u8,

    /// The time at which the prompt was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that you encrypted the prompt
    /// with.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The name of the default variant for your prompt.
    default_variant: ?[]const u8 = null,

    /// The description of the prompt.
    description: ?[]const u8 = null,

    /// The unique identifier of the prompt.
    id: []const u8,

    /// The name of the prompt.
    name: []const u8,

    /// The time at which the prompt was last updated.
    updated_at: i64,

    /// A list of objects, each containing details about a variant of the prompt.
    variants: ?[]const PromptVariant = null,

    /// The version of the prompt. When you create a prompt, the version created is
    /// the `DRAFT` version.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .default_variant = "defaultVariant",
        .description = "description",
        .id = "id",
        .name = "name",
        .updated_at = "updatedAt",
        .variants = "variants",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePromptInput, options: CallOptions) !CreatePromptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePromptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prompts/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customer_encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerEncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_variant) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultVariant\":");
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
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.variants) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"variants\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePromptOutput {
    const result: CreatePromptOutput = try aws.json.parseJsonObject(
        CreatePromptOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
