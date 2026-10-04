const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainNameStatus = @import("domain_name_status.zig").DomainNameStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;
const RoutingMode = @import("routing_mode.zig").RoutingMode;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

pub const GetDomainNameInput = struct {
    /// The name of the DomainName resource.
    domain_name: []const u8,

    /// The identifier for the domain name resource. Required for private custom
    /// domain names.
    domain_name_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .domain_name_id = "domainNameId",
    };
};

pub const GetDomainNameOutput = @import("domain_name.zig").DomainName;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainNameInput, options: CallOptions) !GetDomainNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainNameId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainNameOutput {
    var result: GetDomainNameOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainNameOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
