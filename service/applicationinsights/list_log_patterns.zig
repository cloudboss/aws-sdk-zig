const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogPattern = @import("log_pattern.zig").LogPattern;

pub const ListLogPatternsInput = struct {
    /// The Amazon Web Services account ID for the resource group owner.
    account_id: ?[]const u8 = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned `NextToken` value.
    max_results: ?i32 = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// The name of the log pattern set.
    pattern_set_name: ?[]const u8 = null,

    /// The name of the resource group.
    resource_group_name: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pattern_set_name = "PatternSetName",
        .resource_group_name = "ResourceGroupName",
    };
};

pub const ListLogPatternsOutput = struct {
    /// The Amazon Web Services account ID for the resource group owner.
    account_id: ?[]const u8 = null,

    /// The list of log patterns.
    log_patterns: ?[]const LogPattern = null,

    /// The token used to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The name of the resource group.
    resource_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .log_patterns = "LogPatterns",
        .next_token = "NextToken",
        .resource_group_name = "ResourceGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLogPatternsInput, options: CallOptions) !ListLogPatternsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLogPatternsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.ListLogPatterns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLogPatternsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLogPatternsOutput, body, allocator);
}
