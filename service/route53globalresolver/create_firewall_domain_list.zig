const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const CreateFirewallDomainListInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// An optional description for the firewall domain list.
    description: ?[]const u8 = null,

    /// The ID of the Route 53 Global Resolver that the domain list will be
    /// associated with.
    global_resolver_id: []const u8,

    /// A descriptive name for the firewall domain list.
    name: []const u8,

    /// An array of user-defined keys and optional values. These tags can be used
    /// for categorization and organization.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .global_resolver_id = "globalResolverId",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateFirewallDomainListOutput = struct {
    /// An Amazon Resource Name (ARN) for the domain list.
    arn: []const u8,

    /// The time and date the domain list was created on.
    created_at: i64,

    /// Description for the domain list.
    description: ?[]const u8 = null,

    /// Number of domains in the domain list.
    domain_count: i32,

    /// The ID of the Route 53 Global Resolver that the domain list is associated
    /// with.
    global_resolver_id: []const u8,

    /// ID of the domain list.
    id: []const u8,

    /// Name of the domain list.
    name: []const u8,

    /// Creation status of the domain list.
    status: CRResourceStatus,

    /// The time and date the domain list was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .domain_count = "domainCount",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFirewallDomainListInput, options: CallOptions) !CreateFirewallDomainListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFirewallDomainListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/firewall-domain-lists/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFirewallDomainListOutput {
    var result: CreateFirewallDomainListOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFirewallDomainListOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
