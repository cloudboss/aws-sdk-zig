const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationExceptionResourceKey = @import("remediation_exception_resource_key.zig").RemediationExceptionResourceKey;
const RemediationException = @import("remediation_exception.zig").RemediationException;

pub const DescribeRemediationExceptionsInput = struct {
    /// The name of the Config rule.
    config_rule_name: []const u8,

    /// The maximum number of RemediationExceptionResourceKey returned on each page.
    /// The default is 25. If you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned in a previous request that you use to
    /// request the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// An exception list of resource exception keys to be processed with the
    /// current request. Config adds exception for each resource key. For example,
    /// Config adds 3 exceptions for 3 resource keys.
    resource_keys: ?[]const RemediationExceptionResourceKey = null,

    pub const json_field_names = .{
        .config_rule_name = "ConfigRuleName",
        .limit = "Limit",
        .next_token = "NextToken",
        .resource_keys = "ResourceKeys",
    };
};

pub const DescribeRemediationExceptionsOutput = struct {
    /// The `nextToken` string returned in a previous request that you use to
    /// request the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// Returns a list of remediation exception objects.
    remediation_exceptions: ?[]const RemediationException = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .remediation_exceptions = "RemediationExceptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRemediationExceptionsInput, options: CallOptions) !DescribeRemediationExceptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRemediationExceptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeRemediationExceptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRemediationExceptionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRemediationExceptionsOutput, body, allocator);
}
