const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogScope = @import("log_scope.zig").LogScope;
const Scope = @import("scope.zig").Scope;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;

pub const ListLoggingConfigurationsInput = struct {
    /// The maximum number of objects that you want WAF to return for this request.
    /// If more
    /// objects are available, in the response, WAF provides a
    /// `NextMarker` value that you can use in a subsequent call to get the next
    /// batch of objects.
    limit: ?i32 = null,

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

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    pub const json_field_names = .{
        .limit = "Limit",
        .log_scope = "LogScope",
        .next_marker = "NextMarker",
        .scope = "Scope",
    };
};

pub const ListLoggingConfigurationsOutput = struct {
    /// Array of logging configurations. If you specified a `Limit` in your request,
    /// this might not be the full list.
    logging_configurations: ?[]const LoggingConfiguration = null,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .logging_configurations = "LoggingConfigurations",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLoggingConfigurationsInput, options: CallOptions) !ListLoggingConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLoggingConfigurationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListLoggingConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLoggingConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLoggingConfigurationsOutput, body, allocator);
}
