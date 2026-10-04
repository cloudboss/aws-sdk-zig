const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateAutomatedReasoningPolicyVersionInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error.
    client_request_token: ?[]const u8 = null,

    /// The hash of the current policy definition used as a concurrency token to
    /// ensure the policy hasn't been modified since you last retrieved it.
    last_updated_definition_hash: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy for which
    /// to create a version.
    policy_arn: []const u8,

    /// A list of tags to associate with the policy version.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .last_updated_definition_hash = "lastUpdatedDefinitionHash",
        .policy_arn = "policyArn",
        .tags = "tags",
    };
};

pub const CreateAutomatedReasoningPolicyVersionOutput = struct {
    /// The timestamp when the policy version was created.
    created_at: i64,

    /// The hash of the policy definition for this version.
    definition_hash: []const u8,

    /// The description of the policy version.
    description: ?[]const u8 = null,

    /// The name of the policy version.
    name: []const u8,

    /// The versioned Amazon Resource Name (ARN) of the policy version.
    policy_arn: []const u8,

    /// The version number of the policy version.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition_hash = "definitionHash",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomatedReasoningPolicyVersionInput, options: CallOptions) !CreateAutomatedReasoningPolicyVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutomatedReasoningPolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lastUpdatedDefinitionHash\":");
    try aws.json.writeValue(@TypeOf(input.last_updated_definition_hash), input.last_updated_definition_hash, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutomatedReasoningPolicyVersionOutput {
    var result: CreateAutomatedReasoningPolicyVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAutomatedReasoningPolicyVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
