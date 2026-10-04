const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainUnitOwnerProperties = @import("domain_unit_owner_properties.zig").DomainUnitOwnerProperties;

pub const CreateDomainUnitInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the domain unit.
    description: ?[]const u8 = null,

    /// The ID of the domain where you want to crate a domain unit.
    domain_identifier: []const u8,

    /// The name of the domain unit.
    name: []const u8,

    /// The ID of the parent domain unit.
    parent_domain_unit_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .name = "name",
        .parent_domain_unit_identifier = "parentDomainUnitIdentifier",
    };
};

pub const CreateDomainUnitOutput = struct {
    /// The IDs of the ancestor domain units.
    ancestor_domain_unit_ids: ?[]const []const u8 = null,

    /// The timestamp at which the domain unit was created.
    created_at: ?i64 = null,

    /// The user who created the domain unit.
    created_by: ?[]const u8 = null,

    /// The description of the domain unit.
    description: ?[]const u8 = null,

    /// The ID of the domain where the domain unit was created.
    domain_id: []const u8,

    /// The ID of the domain unit.
    id: []const u8,

    /// The name of the domain unit.
    name: []const u8,

    /// The owners of the domain unit.
    owners: ?[]const DomainUnitOwnerProperties = null,

    /// The ID of the parent domain unit.
    parent_domain_unit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ancestor_domain_unit_ids = "ancestorDomainUnitIds",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .id = "id",
        .name = "name",
        .owners = "owners",
        .parent_domain_unit_id = "parentDomainUnitId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainUnitInput, options: CallOptions) !CreateDomainUnitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainUnitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/domain-units");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"parentDomainUnitIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.parent_domain_unit_identifier), input.parent_domain_unit_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainUnitOutput {
    var result: CreateDomainUnitOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainUnitOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
