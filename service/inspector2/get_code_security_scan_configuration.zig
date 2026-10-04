const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeSecurityScanConfiguration = @import("code_security_scan_configuration.zig").CodeSecurityScanConfiguration;
const ConfigurationLevel = @import("configuration_level.zig").ConfigurationLevel;
const ScopeSettings = @import("scope_settings.zig").ScopeSettings;

pub const GetCodeSecurityScanConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the scan configuration to retrieve.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .scan_configuration_arn = "scanConfigurationArn",
    };
};

pub const GetCodeSecurityScanConfigurationOutput = struct {
    /// The configuration settings for the code security scan.
    configuration: ?CodeSecurityScanConfiguration = null,

    /// The timestamp when the scan configuration was created.
    created_at: ?i64 = null,

    /// The timestamp when the scan configuration was last updated.
    last_updated_at: ?i64 = null,

    /// The security level for the scan configuration.
    level: ?ConfigurationLevel = null,

    /// The name of the scan configuration.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the scan configuration.
    scan_configuration_arn: ?[]const u8 = null,

    /// The scope settings that define which repositories will be scanned. If the
    /// `ScopeSetting` parameter is `ALL` the scan configuration applies
    /// to all existing and future projects imported into Amazon Inspector.
    scope_settings: ?ScopeSettings = null,

    /// The tags associated with the scan configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .level = "level",
        .name = "name",
        .scan_configuration_arn = "scanConfigurationArn",
        .scope_settings = "scopeSettings",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCodeSecurityScanConfigurationInput, options: CallOptions) !GetCodeSecurityScanConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCodeSecurityScanConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/scan-configuration/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.scan_configuration_arn), input.scan_configuration_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCodeSecurityScanConfigurationOutput {
    var result: GetCodeSecurityScanConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCodeSecurityScanConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
