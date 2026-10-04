const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InlineArchiveRule = @import("inline_archive_rule.zig").InlineArchiveRule;
const AnalyzerConfiguration = @import("analyzer_configuration.zig").AnalyzerConfiguration;
const Type = @import("type.zig").Type;

pub const CreateAnalyzerInput = struct {
    /// The name of the analyzer to create.
    analyzer_name: []const u8,

    /// Specifies the archive rules to add for the analyzer. Archive rules
    /// automatically archive findings that meet the criteria you define for the
    /// rule.
    archive_rules: ?[]const InlineArchiveRule = null,

    /// A client token.
    client_token: ?[]const u8 = null,

    /// Specifies the configuration of the analyzer. If the analyzer is an unused
    /// access analyzer, the specified scope of unused access is used for the
    /// configuration. If the analyzer is an internal access analyzer, the specified
    /// internal access analysis rules are used for the configuration.
    configuration: ?AnalyzerConfiguration = null,

    /// An array of key-value pairs to apply to the analyzer. You can use the set of
    /// Unicode letters, digits, whitespace, `_`, `.`, `/`, `=`, `+`, and `-`.
    ///
    /// For the tag key, you can specify a value that is 1 to 128 characters in
    /// length and cannot be prefixed with `aws:`.
    ///
    /// For the tag value, you can specify a value that is 0 to 256 characters in
    /// length.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of analyzer to create. You can create only one analyzer per account
    /// per Region. You can create up to 5 analyzers per organization per Region.
    @"type": Type,

    pub const json_field_names = .{
        .analyzer_name = "analyzerName",
        .archive_rules = "archiveRules",
        .client_token = "clientToken",
        .configuration = "configuration",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateAnalyzerOutput = struct {
    /// The ARN of the analyzer that was created by the request.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnalyzerInput, options: CallOptions) !CreateAnalyzerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnalyzerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/analyzer";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analyzerName\":");
    try aws.json.writeValue(@TypeOf(input.analyzer_name), input.analyzer_name, allocator, &body_buf);
    has_prev = true;
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnalyzerOutput {
    const result: CreateAnalyzerOutput = try aws.json.parseJsonObject(
        CreateAnalyzerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
