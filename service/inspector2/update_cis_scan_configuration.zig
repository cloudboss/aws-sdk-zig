const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Schedule = @import("schedule.zig").Schedule;
const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;
const UpdateCisTargets = @import("update_cis_targets.zig").UpdateCisTargets;

pub const UpdateCisScanConfigurationInput = struct {
    /// The CIS scan configuration ARN.
    scan_configuration_arn: []const u8,

    /// The scan name for the CIS scan configuration.
    scan_name: ?[]const u8 = null,

    /// The schedule for the CIS scan configuration.
    schedule: ?Schedule = null,

    /// The security level for the CIS scan configuration. Security level refers to
    /// the
    /// Benchmark levels that CIS assigns to a profile.
    security_level: ?CisSecurityLevel = null,

    /// The targets for the CIS scan configuration.
    targets: ?UpdateCisTargets = null,

    pub const json_field_names = .{
        .scan_configuration_arn = "scanConfigurationArn",
        .scan_name = "scanName",
        .schedule = "schedule",
        .security_level = "securityLevel",
        .targets = "targets",
    };
};

pub const UpdateCisScanConfigurationOutput = struct {
    /// The CIS scan configuration ARN.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .scan_configuration_arn = "scanConfigurationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCisScanConfigurationInput, options: CallOptions) !UpdateCisScanConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCisScanConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cis/scan-configuration/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.scan_configuration_arn), input.scan_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (input.scan_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scanName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targets\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCisScanConfigurationOutput {
    var result: UpdateCisScanConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCisScanConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
