const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;
const ConfigurationPolicyAssociationStatus = @import("configuration_policy_association_status.zig").ConfigurationPolicyAssociationStatus;
const AssociationType = @import("association_type.zig").AssociationType;
const TargetType = @import("target_type.zig").TargetType;

pub const StartConfigurationPolicyAssociationInput = struct {
    /// The Amazon Resource Name (ARN) of a configuration policy, the universally
    /// unique identifier (UUID) of a
    /// configuration policy, or a value of `SELF_MANAGED_SECURITY_HUB` for a
    /// self-managed configuration.
    configuration_policy_identifier: []const u8,

    /// The identifier of the target account, organizational unit, or the root to
    /// associate with the specified configuration.
    target: Target,

    pub const json_field_names = .{
        .configuration_policy_identifier = "ConfigurationPolicyIdentifier",
        .target = "Target",
    };
};

pub const StartConfigurationPolicyAssociationOutput = struct {
    /// The current status of the association between the specified target and the
    /// configuration.
    association_status: ?ConfigurationPolicyAssociationStatus = null,

    /// An explanation for a `FAILED` value for `AssociationStatus`.
    association_status_message: ?[]const u8 = null,

    /// Indicates whether the association between the specified target and the
    /// configuration was directly applied by the
    /// Security Hub CSPM delegated administrator or inherited from a parent.
    association_type: ?AssociationType = null,

    /// The UUID of the configuration policy.
    configuration_policy_id: ?[]const u8 = null,

    /// The identifier of the target account, organizational unit, or the
    /// organization root with which the configuration is associated.
    target_id: ?[]const u8 = null,

    /// Indicates whether the target is an Amazon Web Services account,
    /// organizational unit, or the organization root.
    target_type: ?TargetType = null,

    /// The date and time, in UTC and ISO 8601 format, that the configuration policy
    /// association was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .association_status_message = "AssociationStatusMessage",
        .association_type = "AssociationType",
        .configuration_policy_id = "ConfigurationPolicyId",
        .target_id = "TargetId",
        .target_type = "TargetType",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConfigurationPolicyAssociationInput, options: CallOptions) !StartConfigurationPolicyAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartConfigurationPolicyAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationPolicyAssociation/associate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationPolicyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.configuration_policy_identifier), input.configuration_policy_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartConfigurationPolicyAssociationOutput {
    const result: StartConfigurationPolicyAssociationOutput = try aws.json.parseJsonObject(
        StartConfigurationPolicyAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
