const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainValidationSummary = @import("domain_validation_summary.zig").DomainValidationSummary;

pub const ListCertificateDomainValidationsInput = struct {
    /// The Amazon Resource Name (ARN) of the certificate for which to list domain
    /// validation summaries.
    certificate_arn: []const u8,

    /// The maximum number of domain validation summaries to return. If you don't
    /// specify a value, the default is 1000.
    max_items: ?i32 = null,

    /// A token returned by a previous call to `ListCertificateDomainValidations`.
    /// If the number of results exceeds `MaxItems`, use this token to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .max_items = "MaxItems",
        .next_token = "NextToken",
    };
};

pub const ListCertificateDomainValidationsOutput = struct {
    /// A list of DomainValidationSummary objects, one for each domain on the
    /// certificate. Each object contains the domain name and its active and
    /// requested validation configurations.
    domain_validation_summary_list: ?[]const DomainValidationSummary = null,

    /// If the number of results exceeds `MaxItems`, this token is included in the
    /// response. Use this token in a subsequent `ListCertificateDomainValidations`
    /// request to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_validation_summary_list = "DomainValidationSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCertificateDomainValidationsInput, options: CallOptions) !ListCertificateDomainValidationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCertificateDomainValidationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm", "ACM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.ListCertificateDomainValidations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCertificateDomainValidationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCertificateDomainValidationsOutput, body, allocator);
}
