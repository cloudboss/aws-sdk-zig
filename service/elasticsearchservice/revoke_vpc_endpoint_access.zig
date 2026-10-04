const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RevokeVpcEndpointAccessInput = struct {
    /// The account ID to revoke access from.
    account: []const u8,

    /// The name of the OpenSearch Service domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .account = "Account",
        .domain_name = "DomainName",
    };
};

pub const RevokeVpcEndpointAccessOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeVpcEndpointAccessInput, options: CallOptions) !RevokeVpcEndpointAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeVpcEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/revokeVpcEndpointAccess");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Account\":");
    try aws.json.writeValue(@TypeOf(input.account), input.account, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeVpcEndpointAccessOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RevokeVpcEndpointAccessOutput = .{};

    return result;
}
