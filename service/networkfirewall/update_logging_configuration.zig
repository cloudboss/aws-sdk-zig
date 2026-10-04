const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;

pub const UpdateLoggingConfigurationInput = struct {
    /// A boolean that lets you enable or disable the detailed firewall monitoring
    /// dashboard on the firewall.
    ///
    /// The monitoring dashboard provides comprehensive visibility into your
    /// firewall's flow logs and alert logs.
    /// After you enable detailed monitoring, you can access these dashboards
    /// directly from the **Monitoring** page of the Network Firewall console.
    ///
    /// Specify `TRUE` to enable the the detailed monitoring dashboard on the
    /// firewall.
    /// Specify `FALSE` to disable the the detailed monitoring dashboard on the
    /// firewall.
    enable_monitoring_dashboard: ?bool = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_name: ?[]const u8 = null,

    /// Defines how Network Firewall performs logging for a firewall. If you omit
    /// this setting,
    /// Network Firewall disables logging for the firewall.
    logging_configuration: ?LoggingConfiguration = null,

    pub const json_field_names = .{
        .enable_monitoring_dashboard = "EnableMonitoringDashboard",
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .logging_configuration = "LoggingConfiguration",
    };
};

pub const UpdateLoggingConfigurationOutput = struct {
    /// A boolean that reflects whether or not the firewall monitoring dashboard is
    /// enabled on a firewall.
    ///
    /// Returns `TRUE` when the firewall monitoring dashboard is enabled on the
    /// firewall.
    /// Returns `FALSE` when the firewall monitoring dashboard is not enabled on the
    /// firewall.
    enable_monitoring_dashboard: ?bool = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: ?[]const u8 = null,

    logging_configuration: ?LoggingConfiguration = null,

    pub const json_field_names = .{
        .enable_monitoring_dashboard = "EnableMonitoringDashboard",
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .logging_configuration = "LoggingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLoggingConfigurationInput, options: CallOptions) !UpdateLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.UpdateLoggingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLoggingConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLoggingConfigurationOutput, body, allocator);
}
