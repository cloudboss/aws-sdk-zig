const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RetrieveDomainAuthCodeInput = struct {
    /// The name of the domain that you want to get an authorization code for.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const RetrieveDomainAuthCodeOutput = struct {
    /// The authorization code for the domain.
    auth_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_code = "AuthCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveDomainAuthCodeInput, options: CallOptions) !RetrieveDomainAuthCodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveDomainAuthCodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.RetrieveDomainAuthCode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveDomainAuthCodeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RetrieveDomainAuthCodeOutput, body, allocator);
}
