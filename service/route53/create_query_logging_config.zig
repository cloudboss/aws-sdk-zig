const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLoggingConfig = @import("query_logging_config.zig").QueryLoggingConfig;
const serde = @import("serde.zig");

pub const CreateQueryLoggingConfigInput = struct {
    /// The Amazon Resource Name (ARN) for the log group that you want to Amazon
    /// Route 53 to
    /// send query logs to. This is the format of the ARN:
    ///
    /// arn:aws:logs:*region*:*account-id*:log-group:*log_group_name*
    ///
    /// To get the ARN for a log group, you can use the CloudWatch console, the
    /// [DescribeLogGroups](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeLogGroups.html) API action, the [describe-log-groups](https://docs.aws.amazon.com/cli/latest/reference/logs/describe-log-groups.html)
    /// command, or the applicable command in one of the Amazon Web Services SDKs.
    cloud_watch_logs_log_group_arn: []const u8,

    /// The ID of the hosted zone that you want to log queries for. You can log
    /// queries only
    /// for public hosted zones.
    hosted_zone_id: []const u8,
};

pub const CreateQueryLoggingConfigOutput = struct {
    /// The unique URL representing the new query logging configuration.
    location: []const u8,

    /// A complex type that contains the ID for a query logging configuration, the
    /// ID of the
    /// hosted zone that you want to log queries for, and the ARN for the log group
    /// that you
    /// want Amazon Route 53 to send query logs to.
    query_logging_config: ?QueryLoggingConfig = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueryLoggingConfigInput, options: CallOptions) !CreateQueryLoggingConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueryLoggingConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/queryloggingconfig";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateQueryLoggingConfigRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CloudWatchLogsLogGroupArn>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.cloud_watch_logs_log_group_arn);
    try body_buf.appendSlice(allocator, "</CloudWatchLogsLogGroupArn>");
    try body_buf.appendSlice(allocator, "<HostedZoneId>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.hosted_zone_id);
    try body_buf.appendSlice(allocator, "</HostedZoneId>");
    try body_buf.appendSlice(allocator, "</CreateQueryLoggingConfigRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueryLoggingConfigOutput {
    var result: CreateQueryLoggingConfigOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "QueryLoggingConfig")) {
                    result.query_logging_config = try serde.deserializeQueryLoggingConfig(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
