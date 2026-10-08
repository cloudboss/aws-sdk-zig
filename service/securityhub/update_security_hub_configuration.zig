const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlFindingGenerator = @import("control_finding_generator.zig").ControlFindingGenerator;

pub const UpdateSecurityHubConfigurationInput = struct {
    /// Whether to automatically enable new controls when they are added to
    /// standards that are
    /// enabled.
    ///
    /// By default, this is set to `true`, and new controls are enabled
    /// automatically. To not automatically enable new controls, set this to
    /// `false`.
    ///
    /// When you automatically enable new controls, you can interact with the
    /// controls in
    /// the console and programmatically immediately after release. However,
    /// automatically enabled controls have a temporary default status of
    /// `DISABLED`. It can take up to several days for Security Hub CSPM to process
    /// the control release and designate the
    /// control as `ENABLED` in your account. During the processing period, you can
    /// manually enable or disable a
    /// control, and Security Hub CSPM will maintain that designation regardless of
    /// whether you have `AutoEnableControls` set to
    /// `true`.
    auto_enable_controls: ?bool = null,

    /// Updates whether the calling account has consolidated control findings turned
    /// on.
    /// If the value for this field is set to
    /// `SECURITY_CONTROL`, Security Hub CSPM generates a single finding for a
    /// control check even when the check
    /// applies to multiple enabled standards.
    ///
    /// If the value for this field is set to `STANDARD_CONTROL`, Security Hub CSPM
    /// generates separate findings
    /// for a control check when the check applies to multiple enabled standards.
    ///
    /// For accounts that are part of an organization, this value can only be
    /// updated in the administrator account.
    control_finding_generator: ?ControlFindingGenerator = null,

    pub const json_field_names = .{
        .auto_enable_controls = "AutoEnableControls",
        .control_finding_generator = "ControlFindingGenerator",
    };
};

pub const UpdateSecurityHubConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityHubConfigurationInput, options: CallOptions) !UpdateSecurityHubConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityHubConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accounts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_enable_controls) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoEnableControls\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.control_finding_generator) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ControlFindingGenerator\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityHubConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateSecurityHubConfigurationOutput = .{};

    return result;
}
