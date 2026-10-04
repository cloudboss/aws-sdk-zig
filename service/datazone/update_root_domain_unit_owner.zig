const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateRootDomainUnitOwnerInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The current owner of the root domain unit.
    current_owner: []const u8,

    /// The ID of the domain where the root domain unit owner is to be updated.
    domain_identifier: []const u8,

    /// The new owner of the root domain unit.
    new_owner: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .current_owner = "currentOwner",
        .domain_identifier = "domainIdentifier",
        .new_owner = "newOwner",
    };
};

pub const UpdateRootDomainUnitOwnerOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRootDomainUnitOwnerInput, options: CallOptions) !UpdateRootDomainUnitOwnerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRootDomainUnitOwnerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/root-domain-unit-owner");
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
    try body_buf.appendSlice(allocator, "\"currentOwner\":");
    try aws.json.writeValue(@TypeOf(input.current_owner), input.current_owner, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"newOwner\":");
    try aws.json.writeValue(@TypeOf(input.new_owner), input.new_owner, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRootDomainUnitOwnerOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateRootDomainUnitOwnerOutput = .{};

    return result;
}
