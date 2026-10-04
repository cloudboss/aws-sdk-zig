const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogLevel = @import("log_level.zig").LogLevel;
const LogEventConfiguration = @import("log_event_configuration.zig").LogEventConfiguration;

pub const GetV2LoggingOptionsInput = struct {
    /// The flag is used to get all the event types and their respective
    /// configuration that event-based logging supports.
    verbose: ?bool = null,

    pub const json_field_names = .{
        .verbose = "verbose",
    };
};

pub const GetV2LoggingOptionsOutput = struct {
    /// The default log level.
    default_log_level: ?LogLevel = null,

    /// Disables all logs.
    disable_all_logs: ?bool = null,

    /// The list of event configurations that override account-level logging.
    event_configurations: ?[]const LogEventConfiguration = null,

    /// The IAM role ARN IoT uses to write to your CloudWatch logs.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_log_level = "defaultLogLevel",
        .disable_all_logs = "disableAllLogs",
        .event_configurations = "eventConfigurations",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetV2LoggingOptionsInput, options: CallOptions) !GetV2LoggingOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetV2LoggingOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2LoggingOptions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.verbose) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "verbose=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetV2LoggingOptionsOutput {
    var result: GetV2LoggingOptionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetV2LoggingOptionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
