const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RejectDomainNameAccessAssociationInput = struct {
    /// The ARN of the domain name access association resource.
    domain_name_access_association_arn: []const u8,

    /// The ARN of the domain name.
    domain_name_arn: []const u8,

    pub const json_field_names = .{
        .domain_name_access_association_arn = "domainNameAccessAssociationArn",
        .domain_name_arn = "domainNameArn",
    };
};

pub const RejectDomainNameAccessAssociationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RejectDomainNameAccessAssociationInput, options: CallOptions) !RejectDomainNameAccessAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RejectDomainNameAccessAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/rejectdomainnameaccessassociations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domainNameAccessAssociationArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain_name_access_association_arn);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domainNameArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain_name_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RejectDomainNameAccessAssociationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RejectDomainNameAccessAssociationOutput = .{};

    return result;
}
