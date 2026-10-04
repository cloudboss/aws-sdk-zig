const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const LocationIdentifier = @import("location_identifier.zig").LocationIdentifier;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;
const InstrumentationConfiguration = @import("instrumentation_configuration.zig").InstrumentationConfiguration;

pub const GetInstrumentationConfigurationInput = struct {
    /// Environment name for the instrumentation configuration.
    environment: []const u8,

    /// Type of instrumentation configuration (BREAKPOINT or PROBE).
    /// Required to identify the configuration to retrieve.
    instrumentation_type: InstrumentationType,

    /// Location identifier - either full code location or a pre-computed hash.
    location_identifier: LocationIdentifier,

    /// Service name for the instrumentation configuration.
    service: []const u8,

    /// Signal type for the instrumentation configuration.
    signal_type: DynamicInstrumentationSignalType,

    pub const json_field_names = .{
        .environment = "Environment",
        .instrumentation_type = "InstrumentationType",
        .location_identifier = "LocationIdentifier",
        .service = "Service",
        .signal_type = "SignalType",
    };
};

pub const GetInstrumentationConfigurationOutput = struct {
    /// The complete instrumentation configuration, including its location hash,
    /// capture settings, filters, expiration, and creation time.
    configuration: ?InstrumentationConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstrumentationConfigurationInput, options: CallOptions) !GetInstrumentationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstrumentationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-instrumentation-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstrumentationType\":");
    try aws.json.writeValue(@TypeOf(input.instrumentation_type), input.instrumentation_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LocationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.location_identifier), input.location_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Service\":");
    try aws.json.writeValue(@TypeOf(input.service), input.service, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SignalType\":");
    try aws.json.writeValue(@TypeOf(input.signal_type), input.signal_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstrumentationConfigurationOutput {
    const result: GetInstrumentationConfigurationOutput = try aws.json.parseJsonObject(
        GetInstrumentationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
