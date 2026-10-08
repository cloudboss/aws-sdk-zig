const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppMonitorConfiguration = @import("app_monitor_configuration.zig").AppMonitorConfiguration;
const CustomEvents = @import("custom_events.zig").CustomEvents;
const DeobfuscationConfiguration = @import("deobfuscation_configuration.zig").DeobfuscationConfiguration;

pub const UpdateAppMonitorInput = struct {
    /// A structure that contains much of the configuration data for the app
    /// monitor. If you are using Amazon Cognito for authorization, you must include
    /// this structure in your request, and it must include the ID of the Amazon
    /// Cognito identity pool to use for authorization. If you don't include
    /// `AppMonitorConfiguration`, you must set up your own authorization method.
    /// For more information, see [Authorize your application to send data to Amazon
    /// Web
    /// Services](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-get-started-authorization.html).
    app_monitor_configuration: ?AppMonitorConfiguration = null,

    /// Specifies whether this app monitor allows the web client to define and send
    /// custom events. The default is for custom events to be `DISABLED`.
    ///
    /// For more information about custom events, see [Send custom
    /// events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-custom-events.html).
    custom_events: ?CustomEvents = null,

    /// Data collected by RUM is kept by RUM for 30 days and then deleted. This
    /// parameter specifies whether RUM sends a copy of this telemetry data to
    /// Amazon CloudWatch Logs in your account. This enables you to keep the
    /// telemetry data for more than 30 days, but it does incur Amazon CloudWatch
    /// Logs charges.
    cw_log_enabled: ?bool = null,

    /// A structure that contains the configuration for how an app monitor can
    /// deobfuscate stack traces.
    deobfuscation_configuration: ?DeobfuscationConfiguration = null,

    /// The top-level internet domain name for which your application has
    /// administrative authority.
    domain: ?[]const u8 = null,

    /// List the domain names for which your application has administrative
    /// authority. The `UpdateAppMonitor` allows either the domain or the domain
    /// list.
    domain_list: ?[]const []const u8 = null,

    /// The name of the app monitor to update.
    name: []const u8,

    pub const json_field_names = .{
        .app_monitor_configuration = "AppMonitorConfiguration",
        .custom_events = "CustomEvents",
        .cw_log_enabled = "CwLogEnabled",
        .deobfuscation_configuration = "DeobfuscationConfiguration",
        .domain = "Domain",
        .domain_list = "DomainList",
        .name = "Name",
    };
};

pub const UpdateAppMonitorOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppMonitorInput, options: CallOptions) !UpdateAppMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAppMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appmonitor/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.app_monitor_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AppMonitorConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_events) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomEvents\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cw_log_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CwLogEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deobfuscation_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeobfuscationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Domain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DomainList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAppMonitorOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAppMonitorOutput = .{};

    return result;
}
