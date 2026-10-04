const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InlineArchiveRule = @import("inline_archive_rule.zig").InlineArchiveRule;
const AnalyzerConfiguration = @import("analyzer_configuration.zig").AnalyzerConfiguration;
const Type = @import("type.zig").Type;

pub const CreateServiceLinkedAnalyzerInput = struct {
    /// Specifies the archive rules to add for the analyzer. Archive rules
    /// automatically archive findings that meet the criteria you define for the
    /// rule.
    archive_rules: ?[]const InlineArchiveRule = null,

    /// A client token.
    client_token: ?[]const u8 = null,

    /// Specifies the configuration of the analyzer. The specified scope of unused
    /// access is used for the configuration.
    configuration: ?AnalyzerConfiguration = null,

    /// The type of analyzer to create. Valid values are `ACCOUNT_UNUSED_ACCESS` and
    /// `ORGANIZATION_UNUSED_ACCESS`.
    @"type": Type,

    pub const json_field_names = .{
        .archive_rules = "archiveRules",
        .client_token = "clientToken",
        .configuration = "configuration",
        .@"type" = "type",
    };
};

pub const CreateServiceLinkedAnalyzerOutput = struct {
    /// The ARN of the service-linked analyzer that was created by the request. The
    /// analyzer name follows the format `_AccessAnalyzerFor{ServiceName}-{Id}`
    /// where `Id` is a randomly generated identifier.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceLinkedAnalyzerInput, options: CallOptions) !CreateServiceLinkedAnalyzerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceLinkedAnalyzerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/service-linked-analyzer";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.archive_rules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"archiveRules\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceLinkedAnalyzerOutput {
    const result: CreateServiceLinkedAnalyzerOutput = try aws.json.parseJsonObject(
        CreateServiceLinkedAnalyzerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
