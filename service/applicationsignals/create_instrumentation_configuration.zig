const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaptureConfiguration = @import("capture_configuration.zig").CaptureConfiguration;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const Location = @import("location.zig").Location;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;
const Tag = @import("tag.zig").Tag;

pub const CreateInstrumentationConfigurationInput = struct {
    /// Client-side filters that target specific instances. Each object in the array
    /// is AND-matched on its keys, and multiple objects are OR-matched to decide
    /// where to apply the instrumentation.
    attribute_filters: ?[]const []const aws.map.StringMapEntry = null,

    /// Specifies what to capture when the instrumentation point is hit. Specify
    /// `CodeCapture` for code-level capture settings.
    capture_configuration: CaptureConfiguration,

    /// An optional short description (up to 50 characters) that explains the
    /// purpose of this instrumentation.
    description: ?[]const u8 = null,

    /// The environment that the service is running in, such as
    /// `eks:cluster-prod/namespace` or `ec2:production`.
    environment: []const u8,

    /// For BREAKPOINT: optional, defaults to 24 hours, must be between 5 min and 24
    /// hours.
    /// For PROBE: not supported. PROBE configurations are permanent and persist
    /// until explicitly deleted.
    expires_at: ?i64 = null,

    /// Type of instrumentation: BREAKPOINT (temporary) or PROBE (permanent)
    instrumentation_type: InstrumentationType,

    /// The location where instrumentation should be applied. Specify a
    /// `CodeLocation` for code-level instrumentation.
    location: Location,

    /// The name of the service to instrument. This should match the `service.name`
    /// resource attribute reported by the application.
    service: []const u8,

    /// The telemetry signal type to emit for this instrumentation. The supported
    /// value is `SNAPSHOT`.
    signal_type: DynamicInstrumentationSignalType,

    /// An optional list of key-value pairs to associate with the instrumentation
    /// configuration. Tags can help you organize and categorize your resources.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .attribute_filters = "AttributeFilters",
        .capture_configuration = "CaptureConfiguration",
        .description = "Description",
        .environment = "Environment",
        .expires_at = "ExpiresAt",
        .instrumentation_type = "InstrumentationType",
        .location = "Location",
        .service = "Service",
        .signal_type = "SignalType",
        .tags = "Tags",
    };
};

pub const CreateInstrumentationConfigurationOutput = struct {
    /// ARN for the created instrumentation configuration
    arn: []const u8,

    /// The attribute filters returned with the configuration so SDKs can perform
    /// client-side targeting.
    attribute_filters: ?[]const []const aws.map.StringMapEntry = null,

    /// The capture settings that were stored for this instrumentation
    /// configuration.
    capture_configuration: ?CaptureConfiguration = null,

    /// The server-generated creation timestamp for this instrumentation
    /// configuration.
    created_at: i64,

    /// The optional description that was stored with the instrumentation
    /// configuration.
    description: ?[]const u8 = null,

    /// The environment for the instrumentation configuration, echoed from the
    /// request.
    environment: []const u8,

    /// The timestamp after which this configuration is no longer served to clients.
    /// Present only for `BREAKPOINT` configurations; `PROBE` configurations do not
    /// expire.
    expires_at: ?i64 = null,

    /// The type of instrumentation that was created, echoed from the request.
    instrumentation_type: InstrumentationType,

    /// The location where instrumentation is applied, echoed from the request.
    location: ?Location = null,

    /// A stable hash computed from the location that uniquely identifies this
    /// instrumentation point within the service, environment, and signal type.
    location_hash: []const u8,

    /// The service name for the instrumentation configuration, echoed from the
    /// request.
    service: []const u8,

    /// The telemetry signal type for the instrumentation configuration, echoed from
    /// the request.
    signal_type: DynamicInstrumentationSignalType,

    pub const json_field_names = .{
        .arn = "ARN",
        .attribute_filters = "AttributeFilters",
        .capture_configuration = "CaptureConfiguration",
        .created_at = "CreatedAt",
        .description = "Description",
        .environment = "Environment",
        .expires_at = "ExpiresAt",
        .instrumentation_type = "InstrumentationType",
        .location = "Location",
        .location_hash = "LocationHash",
        .service = "Service",
        .signal_type = "SignalType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstrumentationConfigurationInput, options: CallOptions) !CreateInstrumentationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstrumentationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-instrumentation-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AttributeFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CaptureConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.capture_configuration), input.capture_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (input.expires_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpiresAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstrumentationType\":");
    try aws.json.writeValue(@TypeOf(input.instrumentation_type), input.instrumentation_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Location\":");
    try aws.json.writeValue(@TypeOf(input.location), input.location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Service\":");
    try aws.json.writeValue(@TypeOf(input.service), input.service, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SignalType\":");
    try aws.json.writeValue(@TypeOf(input.signal_type), input.signal_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstrumentationConfigurationOutput {
    const result: CreateInstrumentationConfigurationOutput = try aws.json.parseJsonObject(
        CreateInstrumentationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
