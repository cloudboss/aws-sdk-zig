const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationPolicyAssociation = @import("configuration_policy_association.zig").ConfigurationPolicyAssociation;
const ConfigurationPolicyAssociationSummary = @import("configuration_policy_association_summary.zig").ConfigurationPolicyAssociationSummary;
const UnprocessedConfigurationPolicyAssociation = @import("unprocessed_configuration_policy_association.zig").UnprocessedConfigurationPolicyAssociation;

pub const BatchGetConfigurationPolicyAssociationsInput = struct {
    /// Specifies one or more target account IDs, organizational unit (OU) IDs, or
    /// the root ID to retrieve associations for.
    configuration_policy_association_identifiers: []const ConfigurationPolicyAssociation,

    pub const json_field_names = .{
        .configuration_policy_association_identifiers = "ConfigurationPolicyAssociationIdentifiers",
    };
};

pub const BatchGetConfigurationPolicyAssociationsOutput = struct {
    /// Describes associations for the target accounts, OUs, or the root.
    configuration_policy_associations: ?[]const ConfigurationPolicyAssociationSummary = null,

    /// An array of configuration policy associations, one for each configuration
    /// policy association identifier, that was
    /// specified in the request but couldn’t be processed due to an error.
    unprocessed_configuration_policy_associations: ?[]const UnprocessedConfigurationPolicyAssociation = null,

    pub const json_field_names = .{
        .configuration_policy_associations = "ConfigurationPolicyAssociations",
        .unprocessed_configuration_policy_associations = "UnprocessedConfigurationPolicyAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetConfigurationPolicyAssociationsInput, options: CallOptions) !BatchGetConfigurationPolicyAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetConfigurationPolicyAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationPolicyAssociation/batchget";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationPolicyAssociationIdentifiers\":");
    try aws.json.writeValue(@TypeOf(input.configuration_policy_association_identifiers), input.configuration_policy_association_identifiers, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetConfigurationPolicyAssociationsOutput {
    const result: BatchGetConfigurationPolicyAssociationsOutput = try aws.json.parseJsonObject(
        BatchGetConfigurationPolicyAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
