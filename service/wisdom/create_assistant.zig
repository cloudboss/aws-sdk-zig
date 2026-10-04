const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const AssistantType = @import("assistant_type.zig").AssistantType;
const AssistantData = @import("assistant_data.zig").AssistantData;

pub const CreateAssistantInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The description of the assistant.
    description: ?[]const u8 = null,

    /// The name of the assistant.
    name: []const u8,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// The customer managed key must have a policy that allows `kms:CreateGrant`,
    /// ` kms:DescribeKey`, and `kms:Decrypt/kms:GenerateDataKey` permissions to the
    /// IAM identity using the key
    /// to invoke Wisdom. To use Wisdom with chat, the key policy must also allow
    /// `kms:Decrypt`, `kms:GenerateDataKey*`, and
    /// `kms:DescribeKey` permissions to the `connect.amazonaws.com` service
    /// principal.
    ///
    /// For more information about setting up a customer managed key for Wisdom, see
    /// [Enable Amazon Connect Wisdom
    /// for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-wisdom.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of assistant.
    @"type": AssistantType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateAssistantOutput = struct {
    /// Information about the assistant.
    assistant: ?AssistantData = null,

    pub const json_field_names = .{
        .assistant = "assistant",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssistantInput, options: CallOptions) !CreateAssistantOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssistantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "Wisdom", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/assistants";

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
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.server_side_encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverSideEncryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssistantOutput {
    const result: CreateAssistantOutput = try aws.json.parseJsonObject(
        CreateAssistantOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
