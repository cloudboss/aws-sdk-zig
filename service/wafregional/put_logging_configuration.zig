const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;

pub const PutLoggingConfigurationInput = struct {
    /// The Amazon Kinesis Data Firehose that contains the inspected traffic
    /// information, the redacted fields details, and the Amazon Resource Name (ARN)
    /// of the web ACL
    /// to monitor.
    ///
    /// When specifying `Type` in `RedactedFields`, you must use one of
    /// the following values: `URI`, `QUERY_STRING`, `HEADER`,
    /// or `METHOD`.
    logging_configuration: LoggingConfiguration,

    pub const json_field_names = .{
        .logging_configuration = "LoggingConfiguration",
    };
};

pub const PutLoggingConfigurationOutput = struct {
    /// The LoggingConfiguration that you submitted in the request.
    logging_configuration: ?LoggingConfiguration = null,

    pub const json_field_names = .{
        .logging_configuration = "LoggingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutLoggingConfigurationInput, options: CallOptions) !PutLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.PutLoggingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutLoggingConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutLoggingConfigurationOutput, body, allocator);
}
