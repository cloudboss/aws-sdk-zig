const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const PromptVariant = @import("prompt_variant.zig").PromptVariant;

pub const GetPromptInput = struct {
    /// Controls the scope of data returned. Set to `METADATA_ONLY` to return only
    /// resource metadata. Set to `ALL_DATA` or omit this field to return the full
    /// response.
    included_data: ?IncludedData = null,

    /// The unique identifier of the prompt.
    prompt_identifier: []const u8,

    /// The version of the prompt about which you want to retrieve information. Omit
    /// this field to return information about the working draft of the prompt.
    prompt_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .included_data = "includedData",
        .prompt_identifier = "promptIdentifier",
        .prompt_version = "promptVersion",
    };
};

pub const GetPromptOutput = struct {
    /// The Amazon Resource Name (ARN) of the prompt or the prompt version (if you
    /// specified a version in the request).
    arn: []const u8,

    /// The time at which the prompt was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that the prompt is encrypted
    /// with.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The name of the default variant for the prompt. This value must match the
    /// `name` field in the relevant
    /// [PromptVariant](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptVariant.html) object.
    default_variant: ?[]const u8 = null,

    /// The descriptino of the prompt.
    description: ?[]const u8 = null,

    /// The unique identifier of the prompt.
    id: []const u8,

    /// The name of the prompt.
    name: []const u8,

    /// The time at which the prompt was last updated.
    updated_at: i64,

    /// A list of objects, each containing details about a variant of the prompt.
    variants: ?[]const PromptVariant = null,

    /// The version of the prompt.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPromptInput, options: CallOptions) !GetPromptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPromptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prompts/");
    try path_buf.appendSlice(allocator, input.prompt_identifier);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.included_data) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includedData=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.prompt_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "promptVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPromptOutput {
    const result: GetPromptOutput = try aws.json.parseJsonObject(
        GetPromptOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
