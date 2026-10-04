const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlFindingGenerator = @import("control_finding_generator.zig").ControlFindingGenerator;

pub const EnableSecurityHubInput = struct {
    /// This field, used when enabling Security Hub CSPM, specifies whether the
    /// calling account has consolidated control findings turned on.
    /// If the value for this field is set to
    /// `SECURITY_CONTROL`, Security Hub CSPM generates a single finding for a
    /// control check even when the check
    /// applies to multiple enabled standards.
    ///
    /// If the value for this field is set to `STANDARD_CONTROL`, Security Hub CSPM
    /// generates separate findings
    /// for a control check when the check applies to multiple enabled standards.
    ///
    /// The value for this field in a member account matches the value in the
    /// administrator
    /// account. For accounts that aren't part of an organization, the default value
    /// of this field
    /// is `SECURITY_CONTROL` if you enabled Security Hub CSPM on or after February
    /// 23,
    /// 2023.
    control_finding_generator: ?ControlFindingGenerator = null,

    /// Whether to enable the security standards that Security Hub CSPM has
    /// designated as automatically
    /// enabled. If you don't provide a value for `EnableDefaultStandards`, it is
    /// set
    /// to `true`. To not enable the automatically enabled standards, set
    /// `EnableDefaultStandards` to `false`.
    enable_default_standards: ?bool = null,

    /// The tags to add to the hub resource when you enable Security Hub CSPM.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .control_finding_generator = "ControlFindingGenerator",
        .enable_default_standards = "EnableDefaultStandards",
        .tags = "Tags",
    };
};

pub const EnableSecurityHubOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableSecurityHubInput, options: CallOptions) !EnableSecurityHubOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableSecurityHubInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accounts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.control_finding_generator) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ControlFindingGenerator\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_default_standards) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EnableDefaultStandards\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableSecurityHubOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: EnableSecurityHubOutput = .{};

    return result;
}
