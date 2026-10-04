const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainDescriptionType = @import("domain_description_type.zig").DomainDescriptionType;

pub const DescribeUserPoolDomainInput = struct {
    /// The domain that you want to describe. For custom domains, this is the
    /// fully-qualified
    /// domain name, such as `auth.example.com`. For Amazon Cognito prefix domains,
    /// this is
    /// the prefix alone, such as `auth`.
    domain: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

pub const DescribeUserPoolDomainOutput = struct {
    /// The details of the requested user pool domain.
    domain_description: ?DomainDescriptionType = null,

    pub const json_field_names = .{
        .domain_description = "DomainDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserPoolDomainInput, options: CallOptions) !DescribeUserPoolDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserPoolDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.DescribeUserPoolDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserPoolDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUserPoolDomainOutput, body, allocator);
}
