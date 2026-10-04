const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;

pub const GetConfigurationPolicyInput = struct {
    /// The Amazon Resource Name (ARN) or universally unique identifier (UUID) of
    /// the configuration policy.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetConfigurationPolicyOutput = struct {
    /// The ARN of the configuration policy.
    arn: ?[]const u8 = null,

    /// An object that defines how Security Hub CSPM is configured. It includes
    /// whether Security Hub CSPM is enabled or
    /// disabled, a list of enabled security standards, a list of enabled or
    /// disabled security controls, and a list of custom parameter values for
    /// specified controls.
    /// If the policy includes a list of security controls that are enabled,
    /// Security Hub CSPM disables all other controls (including newly released
    /// controls).
    /// If the policy includes a list of security controls that are disabled,
    /// Security Hub CSPM enables all other controls (including
    /// newly released controls).
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationPolicyInput, options: CallOptions) !GetConfigurationPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configurationPolicy/get/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationPolicyOutput {
    var result: GetConfigurationPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
