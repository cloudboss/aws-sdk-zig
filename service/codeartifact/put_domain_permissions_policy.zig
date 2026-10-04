const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutDomainPermissionsPolicyInput = struct {
    /// The name of the domain on which to set the resource policy.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// A valid displayable JSON Aspen policy string to be set as the access control
    /// resource
    /// policy on the provided domain.
    policy_document: []const u8,

    /// The current revision of the resource policy to be set. This revision is used
    /// for optimistic locking, which
    /// prevents others from overwriting your changes to the domain's resource
    /// policy.
    policy_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .policy_document = "policyDocument",
        .policy_revision = "policyRevision",
    };
};

pub const PutDomainPermissionsPolicyOutput = struct {
    /// The resource policy that was set after processing the request.
    policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDomainPermissionsPolicyInput, options: CallOptions) !PutDomainPermissionsPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDomainPermissionsPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/domain/permissions/policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domain\":");
    try aws.json.writeValue(@TypeOf(input.domain), input.domain, allocator, &body_buf);
    has_prev = true;
    if (input.domain_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainOwner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (input.policy_revision) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyRevision\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDomainPermissionsPolicyOutput {
    var result: PutDomainPermissionsPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutDomainPermissionsPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
