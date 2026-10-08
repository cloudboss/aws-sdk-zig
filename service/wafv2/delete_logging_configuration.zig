const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogScope = @import("log_scope.zig").LogScope;
const LogType = @import("log_type.zig").LogType;

pub const DeleteLoggingConfigurationInput = struct {
    /// The owner of the logging configuration, which must be set to `CUSTOMER` for
    /// the configurations that you manage.
    ///
    /// The log scope `SECURITY_LAKE` indicates a configuration that is managed
    /// through Amazon Security Lake. You can use Security Lake to collect log and
    /// event data from various sources for normalization, analysis, and management.
    /// For information, see
    /// [Collecting data from Amazon Web Services
    /// services](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html)
    /// in the *Amazon Security Lake user guide*.
    ///
    /// The log scope `CLOUDWATCH_TELEMETRY_RULE_MANAGED` indicates a configuration
    /// that is managed through Amazon CloudWatch Logs for telemetry data collection
    /// and analysis. For information, see
    /// [What is Amazon CloudWatch Logs
    /// ?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
    /// in the *Amazon CloudWatch Logs user guide*.
    ///
    /// Default: `CUSTOMER`
    log_scope: ?LogScope = null,

    /// Used to distinguish between various logging options. Currently, there is one
    /// option.
    ///
    /// Default: `WAF_LOGS`
    log_type: ?LogType = null,

    /// The Amazon Resource Name (ARN) of the web ACL from which you want to delete
    /// the LoggingConfiguration.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .log_scope = "LogScope",
        .log_type = "LogType",
        .resource_arn = "ResourceArn",
    };
};

pub const DeleteLoggingConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLoggingConfigurationInput, options: CallOptions) !DeleteLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.DeleteLoggingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLoggingConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
