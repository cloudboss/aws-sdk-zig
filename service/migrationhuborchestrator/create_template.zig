const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateSource = @import("template_source.zig").TemplateSource;

pub const CreateTemplateInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. For more information, see
    /// [Idempotency](https://smithy.io/2.0/spec/behavior-traits.html#idempotencytoken-trait) in the Smithy documentation.
    client_token: ?[]const u8 = null,

    /// The tags to add to the migration workflow template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A description of the migration workflow template.
    template_description: ?[]const u8 = null,

    /// The name of the migration workflow template.
    template_name: []const u8,

    /// The source of the migration workflow template.
    template_source: TemplateSource,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .tags = "tags",
        .template_description = "templateDescription",
        .template_name = "templateName",
        .template_source = "templateSource",
    };
};

pub const CreateTemplateOutput = struct {
    /// The tags added to the migration workflow template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the migration workflow template. The
    /// format for an
    /// Migration Hub Orchestrator template ARN is
    /// `arn:aws:migrationhub-orchestrator:region:account:template/template-abcd1234`.
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// in the *AWS General Reference*.
    template_arn: ?[]const u8 = null,

    /// The ID of the migration workflow template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .tags = "tags",
        .template_arn = "templateArn",
        .template_id = "templateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTemplateInput, options: CallOptions) !CreateTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "migrationhub-orchestrator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/template";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"templateDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateName\":");
    try aws.json.writeValue(@TypeOf(input.template_name), input.template_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateSource\":");
    try aws.json.writeValue(@TypeOf(input.template_source), input.template_source, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTemplateOutput {
    var result: CreateTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
