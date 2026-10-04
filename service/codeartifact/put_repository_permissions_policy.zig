const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutRepositoryPermissionsPolicyInput = struct {
    /// The name of the domain containing the repository to set the resource policy
    /// on.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// A valid displayable JSON Aspen policy string to be set as the access control
    /// resource
    /// policy on the provided repository.
    policy_document: []const u8,

    /// Sets the revision of the resource policy that specifies permissions to
    /// access the repository.
    /// This revision is used for optimistic locking, which prevents others from
    /// overwriting your
    /// changes to the repository's resource policy.
    policy_revision: ?[]const u8 = null,

    /// The name of the repository to set the resource policy on.
    repository: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .policy_document = "policyDocument",
        .policy_revision = "policyRevision",
        .repository = "repository",
    };
};

pub const PutRepositoryPermissionsPolicyOutput = struct {
    /// The resource policy that was set after processing the request.
    policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRepositoryPermissionsPolicyInput, options: CallOptions) !PutRepositoryPermissionsPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRepositoryPermissionsPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/repository/permissions/policy";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
    if (input.domain_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domain-owner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRepositoryPermissionsPolicyOutput {
    var result: PutRepositoryPermissionsPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutRepositoryPermissionsPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
