const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SingleSignOn = @import("single_sign_on.zig").SingleSignOn;

pub const UpdateDomainInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description to be updated as part of the `UpdateDomain` action.
    description: ?[]const u8 = null,

    /// The domain execution role to be updated as part of the `UpdateDomain`
    /// action.
    domain_execution_role: ?[]const u8 = null,

    /// The ID of the Amazon Web Services domain that is to be updated.
    identifier: []const u8,

    /// The name to be updated as part of the `UpdateDomain` action.
    name: ?[]const u8 = null,

    /// The service role of the domain.
    service_role: ?[]const u8 = null,

    /// The single sign-on option to be updated as part of the `UpdateDomain`
    /// action.
    single_sign_on: ?SingleSignOn = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .identifier = "identifier",
        .name = "name",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
    };
};

pub const UpdateDomainOutput = struct {
    /// The description to be updated as part of the `UpdateDomain` action.
    description: ?[]const u8 = null,

    /// The domain execution role to be updated as part of the `UpdateDomain`
    /// action.
    domain_execution_role: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain.
    id: []const u8,

    /// Specifies the timestamp of when the domain was last updated.
    last_updated_at: ?i64 = null,

    /// The name to be updated as part of the `UpdateDomain` action.
    name: ?[]const u8 = null,

    /// The ID of the root domain unit.
    root_domain_unit_id: ?[]const u8 = null,

    /// The service role of the domain.
    service_role: ?[]const u8 = null,

    /// The single sign-on option of the Amazon DataZone domain.
    single_sign_on: ?SingleSignOn = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .root_domain_unit_id = "rootDomainUnitId",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainInput, options: CallOptions) !UpdateDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainExecutionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.single_sign_on) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"singleSignOn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainOutput {
    const result: UpdateDomainOutput = try aws.json.parseJsonObject(
        UpdateDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
