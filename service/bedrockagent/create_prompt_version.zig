const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PromptVariant = @import("prompt_variant.zig").PromptVariant;

pub const CreatePromptVersionInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the version of the prompt.
    description: ?[]const u8 = null,

    /// The unique identifier of the prompt that you want to create a version of.
    prompt_identifier: []const u8,

    /// Any tags that you want to attach to the version of the prompt. For more
    /// information, see [Tagging resources in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .prompt_identifier = "promptIdentifier",
        .tags = "tags",
    };
};

pub const CreatePromptVersionOutput = struct {
    /// The Amazon Resource Name (ARN) of the version of the prompt.
    arn: []const u8,

    /// The time at which the prompt was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key to encrypt the version of the
    /// prompt.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The name of the default variant for the prompt. This value must match the
    /// `name` field in the relevant
    /// [PromptVariant](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptVariant.html) object.
    default_variant: ?[]const u8 = null,

    /// A description for the version.
    description: ?[]const u8 = null,

    /// The unique identifier of the prompt.
    id: []const u8,

    /// The name of the prompt.
    name: []const u8,

    /// The time at which the prompt was last updated.
    updated_at: i64,

    /// A list of objects, each containing details about a variant of the prompt.
    variants: ?[]const PromptVariant = null,

    /// The version of the prompt that was created. Versions are numbered
    /// incrementally, starting from 1.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePromptVersionInput, options: CallOptions) !CreatePromptVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePromptVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prompts/");
    try path_buf.appendSlice(allocator, input.prompt_identifier);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePromptVersionOutput {
    const result: CreatePromptVersionOutput = try aws.json.parseJsonObject(
        CreatePromptVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
