const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyGrantDetail = @import("policy_grant_detail.zig").PolicyGrantDetail;
const TargetEntityType = @import("target_entity_type.zig").TargetEntityType;
const ManagedPolicyType = @import("managed_policy_type.zig").ManagedPolicyType;
const PolicyGrantPrincipal = @import("policy_grant_principal.zig").PolicyGrantPrincipal;

pub const AddPolicyGrantInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The details of the policy grant.
    detail: PolicyGrantDetail,

    /// The ID of the domain where you want to add a policy grant.
    domain_identifier: []const u8,

    /// The ID of the entity (resource) to which you want to add a policy grant.
    entity_identifier: []const u8,

    /// The type of entity (resource) to which the grant is added.
    entity_type: TargetEntityType,

    /// The type of policy that you want to grant.
    policy_type: ManagedPolicyType,

    /// The principal to whom the permissions are granted.
    principal: PolicyGrantPrincipal,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .detail = "detail",
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_type = "entityType",
        .policy_type = "policyType",
        .principal = "principal",
    };
};

pub const AddPolicyGrantOutput = struct {
    /// The ID of the policy grant that was added to a specified entity.
    grant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .grant_id = "grantId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddPolicyGrantInput, options: CallOptions) !AddPolicyGrantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddPolicyGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/policies/managed/");
    try path_buf.appendSlice(allocator, input.entity_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.entity_identifier);
    try path_buf.appendSlice(allocator, "/addGrant");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"detail\":");
    try aws.json.writeValue(@TypeOf(input.detail), input.detail, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyType\":");
    try aws.json.writeValue(@TypeOf(input.policy_type), input.policy_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddPolicyGrantOutput {
    var result: AddPolicyGrantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddPolicyGrantOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
