const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ResendValidationEmailInput = struct {
    /// String that contains the ARN of the requested certificate. The certificate
    /// ARN is generated and returned by the RequestCertificate action as soon as
    /// the request is made. By default, using this parameter causes email to be
    /// sent to all top-level domains you specified in the certificate request. The
    /// ARN must be of the form:
    ///
    /// `arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012`
    certificate_arn: []const u8,

    /// The fully qualified domain name (FQDN) of the certificate that needs to be
    /// validated.
    domain: []const u8,

    /// The base validation domain that will act as the suffix of the email
    /// addresses that are used to send the emails. This must be the same as the
    /// `Domain` value or a superdomain of the `Domain` value. For example, if you
    /// requested a certificate for `site.subdomain.example.com` and specify a
    /// **ValidationDomain** of `subdomain.example.com`, ACM sends email to the the
    /// following five addresses:
    ///
    /// * admin@subdomain.example.com
    /// * administrator@subdomain.example.com
    /// * hostmaster@subdomain.example.com
    /// * postmaster@subdomain.example.com
    /// * webmaster@subdomain.example.com
    validation_domain: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .domain = "Domain",
        .validation_domain = "ValidationDomain",
    };
};

pub const ResendValidationEmailOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResendValidationEmailInput, options: CallOptions) !ResendValidationEmailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ResendValidationEmailInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.ResendValidationEmail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResendValidationEmailOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
