const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AWSResources = @import("aws_resources.zig").AWSResources;
const CodeReviewSettings = @import("code_review_settings.zig").CodeReviewSettings;

pub const CreateAgentSpaceInput = struct {
    /// The AWS resources to associate with the agent space.
    aws_resources: ?AWSResources = null,

    /// The code review settings for the agent space.
    code_review_settings: ?CodeReviewSettings = null,

    /// A description of the agent space.
    description: ?[]const u8 = null,

    /// The identifier of the AWS KMS key to use for encrypting data in the agent
    /// space.
    kms_key_id: ?[]const u8 = null,

    /// The name of the agent space.
    name: []const u8,

    /// The tags to associate with the agent space.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The list of target domain identifiers to associate with the agent space.
    target_domain_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .aws_resources = "awsResources",
        .code_review_settings = "codeReviewSettings",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .tags = "tags",
        .target_domain_ids = "targetDomainIds",
    };
};

pub const CreateAgentSpaceOutput = struct {
    /// The unique identifier of the created agent space.
    agent_space_id: []const u8,

    /// The AWS resources associated with the agent space.
    aws_resources: ?AWSResources = null,

    /// The code review settings for the agent space.
    code_review_settings: ?CodeReviewSettings = null,

    /// The date and time the agent space was created, in UTC format.
    created_at: ?i64 = null,

    /// The description of the agent space.
    description: ?[]const u8 = null,

    /// The identifier of the AWS KMS key used to encrypt data in the agent space.
    kms_key_id: ?[]const u8 = null,

    /// The name of the agent space.
    name: []const u8,

    /// The list of target domain identifiers associated with the agent space.
    target_domain_ids: ?[]const []const u8 = null,

    /// The date and time the agent space was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .aws_resources = "awsResources",
        .code_review_settings = "codeReviewSettings",
        .created_at = "createdAt",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .target_domain_ids = "targetDomainIds",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgentSpaceInput, options: CallOptions) !CreateAgentSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgentSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateAgentSpace";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aws_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"awsResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.code_review_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeReviewSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
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
    if (input.target_domain_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetDomainIds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgentSpaceOutput {
    const result: CreateAgentSpaceOutput = try aws.json.parseJsonObject(
        CreateAgentSpaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
