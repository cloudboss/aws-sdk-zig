const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogPattern = @import("log_pattern.zig").LogPattern;

pub const UpdateLogPatternInput = struct {
    /// The log pattern. The pattern must be DFA compatible. Patterns that utilize
    /// forward
    /// lookahead or backreference constructions are not supported.
    pattern: ?[]const u8 = null,

    /// The name of the log pattern.
    pattern_name: []const u8,

    /// The name of the log pattern set.
    pattern_set_name: []const u8,

    /// Rank of the log pattern. Must be a value between `1` and
    /// `1,000,000`. The patterns are sorted by rank, so we recommend that you set
    /// your highest priority patterns with the lowest rank. A pattern of rank `1`
    /// will
    /// be the first to get matched to a log line. A pattern of rank `1,000,000`
    /// will be
    /// last to get matched. When you configure custom log patterns from the
    /// console, a
    /// `Low` severity pattern translates to a `750,000` rank. A
    /// `Medium` severity pattern translates to a `500,000` rank. And a
    /// `High` severity pattern translates to a `250,000` rank. Rank
    /// values less than `1` or greater than `1,000,000` are reserved for
    /// Amazon Web Services provided patterns.
    rank: ?i32 = null,

    /// The name of the resource group.
    resource_group_name: []const u8,

    pub const json_field_names = .{
        .pattern = "Pattern",
        .pattern_name = "PatternName",
        .pattern_set_name = "PatternSetName",
        .rank = "Rank",
        .resource_group_name = "ResourceGroupName",
    };
};

pub const UpdateLogPatternOutput = struct {
    /// The successfully created log pattern.
    log_pattern: ?LogPattern = null,

    /// The name of the resource group.
    resource_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_pattern = "LogPattern",
        .resource_group_name = "ResourceGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLogPatternInput, options: CallOptions) !UpdateLogPatternOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "applicationinsights", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLogPatternInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.UpdateLogPattern");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLogPatternOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLogPatternOutput, body, allocator);
}
