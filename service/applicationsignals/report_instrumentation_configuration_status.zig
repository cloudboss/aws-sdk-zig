const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstrumentationConfigurationStatusReport = @import("instrumentation_configuration_status_report.zig").InstrumentationConfigurationStatusReport;
const UnprocessedStatusEvent = @import("unprocessed_status_event.zig").UnprocessedStatusEvent;

pub const ReportInstrumentationConfigurationStatusInput = struct {
    /// An array of configuration status reports (up to 100) that include the
    /// instrumentation type, signal type, location hash, status, timestamp, and
    /// optional error cause.
    configurations: []const InstrumentationConfigurationStatusReport,

    /// The environment that the service is running in.
    environment: []const u8,

    /// The service that the reported configurations belong to.
    service: []const u8,

    pub const json_field_names = .{
        .configurations = "Configurations",
        .environment = "Environment",
        .service = "Service",
    };
};

pub const ReportInstrumentationConfigurationStatusOutput = struct {
    /// The environment echoed from the request.
    environment: []const u8,

    /// The service name echoed from the request.
    service: []const u8,

    /// Status events that failed to be processed. Each entry includes the
    /// configuration identifiers, status, timestamp, and a reason for the failure.
    unprocessed_status_events: ?[]const UnprocessedStatusEvent = null,

    pub const json_field_names = .{
        .environment = "Environment",
        .service = "Service",
        .unprocessed_status_events = "UnprocessedStatusEvents",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReportInstrumentationConfigurationStatusInput, options: CallOptions) !ReportInstrumentationConfigurationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ReportInstrumentationConfigurationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/report-instrumentation-configuration-status";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Configurations\":");
    try aws.json.writeValue(@TypeOf(input.configurations), input.configurations, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Service\":");
    try aws.json.writeValue(@TypeOf(input.service), input.service, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReportInstrumentationConfigurationStatusOutput {
    const result: ReportInstrumentationConfigurationStatusOutput = try aws.json.parseJsonObject(
        ReportInstrumentationConfigurationStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
