const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Association = @import("association.zig").Association;

pub const ListCustomDomainAssociationsInput = struct {
    /// The custom domain name’s certificate Amazon resource name (ARN).
    custom_domain_certificate_arn: ?[]const u8 = null,

    /// The custom domain name associated with the workgroup.
    custom_domain_name: ?[]const u8 = null,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use `nextToken` to display the next page of results.
    max_results: ?i32 = null,

    /// When `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_domain_certificate_arn = "customDomainCertificateArn",
        .custom_domain_name = "customDomainName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListCustomDomainAssociationsOutput = struct {
    /// A list of Association objects.
    associations: ?[]const Association = null,

    /// When `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associations = "associations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCustomDomainAssociationsInput, options: CallOptions) !ListCustomDomainAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCustomDomainAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.ListCustomDomainAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCustomDomainAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCustomDomainAssociationsOutput, body, allocator);
}
