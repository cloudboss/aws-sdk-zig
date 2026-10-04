const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyslogConfiguration = @import("syslog_configuration.zig").SyslogConfiguration;

pub const ListSyslogConfigurationsInput = struct {
    /// The name or ARN of the log group to filter syslog configurations for.
    log_group_identifier: ?[]const u8 = null,

    /// The maximum number of syslog configurations to return in the response.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. You received this token from
    /// a previous
    /// call.
    next_token: ?[]const u8 = null,

    /// The ID of the VPC endpoint to filter syslog configurations for.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .vpc_endpoint_id = "vpcEndpointId",
    };
};

pub const ListSyslogConfigurationsOutput = struct {
    /// The token for the next set of items to return. The token expires after 24
    /// hours.
    next_token: ?[]const u8 = null,

    /// The list of syslog configurations.
    syslog_configurations: ?[]const SyslogConfiguration = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .syslog_configurations = "syslogConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSyslogConfigurationsInput, options: CallOptions) !ListSyslogConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSyslogConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListSyslogConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSyslogConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSyslogConfigurationsOutput, body, allocator);
}
