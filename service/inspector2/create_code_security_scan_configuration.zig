const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeSecurityScanConfiguration = @import("code_security_scan_configuration.zig").CodeSecurityScanConfiguration;
const ConfigurationLevel = @import("configuration_level.zig").ConfigurationLevel;
const ScopeSettings = @import("scope_settings.zig").ScopeSettings;

pub const CreateCodeSecurityScanConfigurationInput = struct {
    /// The configuration settings for the code security scan.
    configuration: CodeSecurityScanConfiguration,

    /// The security level for the scan configuration.
    level: ConfigurationLevel,

    /// The name of the scan configuration.
    name: []const u8,

    /// The scope settings that define which repositories will be scanned. Include
    /// this
    /// parameter to create a default scan configuration. Otherwise Amazon Inspector
    /// creates a general scan
    /// configuration.
    ///
    /// A default scan configuration automatically applies to all existing and
    /// future projects
    /// imported into Amazon Inspector. Use the
    /// `BatchAssociateCodeSecurityScanConfiguration`
    /// operation to associate a general scan configuration with projects.
    scope_settings: ?ScopeSettings = null,

    /// The tags to apply to the scan configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .level = "level",
        .name = "name",
        .scope_settings = "scopeSettings",
        .tags = "tags",
    };
};

pub const CreateCodeSecurityScanConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created scan configuration.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .scan_configuration_arn = "scanConfigurationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCodeSecurityScanConfigurationInput, options: CallOptions) !CreateCodeSecurityScanConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCodeSecurityScanConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/scan-configuration/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"level\":");
    try aws.json.writeValue(@TypeOf(input.level), input.level, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.scope_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopeSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCodeSecurityScanConfigurationOutput {
    const result: CreateCodeSecurityScanConfigurationOutput = try aws.json.parseJsonObject(
        CreateCodeSecurityScanConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
