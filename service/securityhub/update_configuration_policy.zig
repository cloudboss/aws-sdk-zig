const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;

pub const UpdateConfigurationPolicyInput = struct {
    /// An object that defines how Security Hub CSPM is configured. It includes
    /// whether Security Hub CSPM is enabled or
    /// disabled, a list of enabled security standards, a list of enabled or
    /// disabled security controls, and a list of custom parameter values for
    /// specified controls.
    /// If you provide a list of security controls that are enabled in the
    /// configuration policy, Security Hub CSPM disables all other controls
    /// (including newly
    /// released controls). If you provide a list of security controls that are
    /// disabled in the configuration policy, Security Hub CSPM
    /// enables all other controls (including newly released controls).
    ///
    /// When updating a configuration policy, provide a complete list of standards
    /// that you want to enable and a complete list
    /// of controls that you want to enable or disable. The updated configuration
    /// replaces the current configuration.
    configuration_policy: ?Policy = null,

    /// The description of the configuration policy.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) or universally unique identifier (UUID) of
    /// the configuration policy.
    identifier: []const u8,

    /// The name of the configuration policy. Alphanumeric characters and the
    /// following ASCII characters are permitted:
    /// `-, ., !, *, /`.
    name: ?[]const u8 = null,

    /// The reason for updating the configuration policy.
    updated_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_policy = "ConfigurationPolicy",
        .description = "Description",
        .identifier = "Identifier",
        .name = "Name",
        .updated_reason = "UpdatedReason",
    };
};

pub const UpdateConfigurationPolicyOutput = struct {
    /// The ARN of the configuration policy.
    arn: ?[]const u8 = null,

    /// An object that defines how Security Hub CSPM is configured. It includes
    /// whether Security Hub CSPM is enabled or
    /// disabled, a list of enabled security standards, a list of enabled or
    /// disabled security controls, and a list of custom parameter values for
    /// specified controls. If the request included a
    /// list of security controls that are enabled in the configuration policy,
    /// Security Hub CSPM disables all other controls (including
    /// newly released controls). If the request included a list of security
    /// controls that are disabled in the configuration policy,
    /// Security Hub CSPM enables all other controls (including newly released
    /// controls).
    configuration_policy: ?Policy = null,

    /// The date and time, in UTC and ISO 8601 format, that the configuration policy
    /// was created.
    created_at: ?i64 = null,

    /// The description of the configuration policy.
    description: ?[]const u8 = null,

    /// The UUID of the configuration policy.
    id: ?[]const u8 = null,

    /// The name of the configuration policy.
    name: ?[]const u8 = null,

    /// The date and time, in UTC and ISO 8601 format, that the configuration policy
    /// was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration_policy = "ConfigurationPolicy",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationPolicyInput, options: CallOptions) !UpdateConfigurationPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configurationPolicy/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.updated_reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UpdatedReason\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationPolicyOutput {
    const result: UpdateConfigurationPolicyOutput = try aws.json.parseJsonObject(
        UpdateConfigurationPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
