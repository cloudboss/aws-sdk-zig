const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateLoadBalancerTlsCertificateInput = struct {
    /// An array of strings listing alternative domains and subdomains for your
    /// SSL/TLS
    /// certificate. Lightsail will de-dupe the names for you. You can have a
    /// maximum of 9
    /// alternative names (in addition to the 1 primary domain). We do not support
    /// wildcards
    /// (`*.example.com`).
    certificate_alternative_names: ?[]const []const u8 = null,

    /// The domain name (`example.com`) for your SSL/TLS certificate.
    certificate_domain_name: []const u8,

    /// The SSL/TLS certificate name.
    ///
    /// You can have up to 10 certificates in your account at one time. Each
    /// Lightsail load
    /// balancer can have up to 2 certificates associated with it at one time. There
    /// is also an
    /// overall limit to the number of certificates that can be issue in a 365-day
    /// period. For more
    /// information, see
    /// [Limits](http://docs.aws.amazon.com/acm/latest/userguide/acm-limits.html).
    certificate_name: []const u8,

    /// The load balancer name where you want to create the SSL/TLS certificate.
    load_balancer_name: []const u8,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .certificate_alternative_names = "certificateAlternativeNames",
        .certificate_domain_name = "certificateDomainName",
        .certificate_name = "certificateName",
        .load_balancer_name = "loadBalancerName",
        .tags = "tags",
    };
};

pub const CreateLoadBalancerTlsCertificateOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoadBalancerTlsCertificateInput, options: CallOptions) !CreateLoadBalancerTlsCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLoadBalancerTlsCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateLoadBalancerTlsCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLoadBalancerTlsCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLoadBalancerTlsCertificateOutput, body, allocator);
}
