const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CertificateSummary = @import("certificate_summary.zig").CertificateSummary;
const Operation = @import("operation.zig").Operation;

pub const CreateCertificateInput = struct {
    /// The name for the certificate.
    certificate_name: []const u8,

    /// The domain name (`example.com`) for the certificate.
    domain_name: []const u8,

    /// An array of strings that specify the alternate domains (`example2.com`) and
    /// subdomains (`blog.example.com`) for the certificate.
    ///
    /// You can specify a maximum of nine alternate domains (in addition to the
    /// primary domain
    /// name).
    ///
    /// Wildcard domain entries (`*.example.com`) are not supported.
    subject_alternative_names: ?[]const []const u8 = null,

    /// The tag keys and optional values to add to the certificate during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .certificate_name = "certificateName",
        .domain_name = "domainName",
        .subject_alternative_names = "subjectAlternativeNames",
        .tags = "tags",
    };
};

pub const CreateCertificateOutput = struct {
    /// An object that describes the certificate created.
    certificate: ?CertificateSummary = null,

    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .certificate = "certificate",
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCertificateInput, options: CallOptions) !CreateCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCertificateOutput, body, allocator);
}
