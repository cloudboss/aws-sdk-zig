const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;

pub const StartConfigurationPolicyDisassociationInput = struct {
    /// The Amazon Resource Name (ARN) of a configuration policy, the universally
    /// unique identifier (UUID) of a
    /// configuration policy, or a value of `SELF_MANAGED_SECURITY_HUB` for a
    /// self-managed configuration.
    configuration_policy_identifier: []const u8,

    /// The identifier of the target account, organizational unit, or the root to
    /// disassociate from the specified configuration.
    target: ?Target = null,

    pub const json_field_names = .{
        .configuration_policy_identifier = "ConfigurationPolicyIdentifier",
        .target = "Target",
    };
};

pub const StartConfigurationPolicyDisassociationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConfigurationPolicyDisassociationInput, options: CallOptions) !StartConfigurationPolicyDisassociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartConfigurationPolicyDisassociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationPolicyAssociation/disassociate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationPolicyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.configuration_policy_identifier), input.configuration_policy_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Target\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartConfigurationPolicyDisassociationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StartConfigurationPolicyDisassociationOutput = .{};

    return result;
}
