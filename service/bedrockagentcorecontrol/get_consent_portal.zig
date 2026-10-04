const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsentPortalIdpConfig = @import("consent_portal_idp_config.zig").ConsentPortalIdpConfig;
const ConsentPortalSource = @import("consent_portal_source.zig").ConsentPortalSource;
const ConsentPortalStatus = @import("consent_portal_status.zig").ConsentPortalStatus;

pub const GetConsentPortalInput = struct {
    /// The identifier of the consent portal. You can specify either the consent
    /// portal ID or its Amazon Resource Name (ARN).
    consent_portal_identifier: []const u8,

    pub const json_field_names = .{
        .consent_portal_identifier = "consentPortalIdentifier",
    };
};

pub const GetConsentPortalOutput = struct {
    /// The Amazon Resource Name (ARN) of the consent portal.
    consent_portal_arn: []const u8,

    /// The unique identifier of the consent portal.
    consent_portal_id: []const u8,

    /// The timestamp for when the consent portal was created.
    created_at: i64,

    /// The description of the consent portal.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that the consent portal
    /// assumes to access the resources defined in its sources.
    execution_role_arn: []const u8,

    /// The identity provider configuration that the consent portal uses to
    /// authenticate end users.
    idp_config: ?ConsentPortalIdpConfig = null,

    /// The name of the consent portal.
    name: []const u8,

    /// The URL used to access the consent portal.
    portal_url: ?[]const u8 = null,

    /// The resources served by the consent portal.
    sources: ?[]const ConsentPortalSource = null,

    /// The current status of the consent portal.
    status: ConsentPortalStatus,

    /// A message that provides additional information about the current status of
    /// the consent portal.
    status_reason: ?[]const u8 = null,

    /// The timestamp for when the consent portal was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .consent_portal_arn = "consentPortalArn",
        .consent_portal_id = "consentPortalId",
        .created_at = "createdAt",
        .description = "description",
        .execution_role_arn = "executionRoleArn",
        .idp_config = "idpConfig",
        .name = "name",
        .portal_url = "portalUrl",
        .sources = "sources",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConsentPortalInput, options: CallOptions) !GetConsentPortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConsentPortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/GetConsentPortal";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"consentPortalIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.consent_portal_identifier), input.consent_portal_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConsentPortalOutput {
    const result: GetConsentPortalOutput = try aws.json.parseJsonObject(
        GetConsentPortalOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
