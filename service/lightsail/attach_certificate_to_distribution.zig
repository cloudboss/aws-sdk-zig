const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Operation = @import("operation.zig").Operation;

pub const AttachCertificateToDistributionInput = struct {
    /// The name of the certificate to attach to a distribution.
    ///
    /// Only certificates with a status of `ISSUED` can be attached to a
    /// distribution.
    ///
    /// Use the `GetCertificates` action to get a list of certificate names that you
    /// can specify.
    ///
    /// This is the name of the certificate resource type and is used only to
    /// reference the
    /// certificate in other API actions. It can be different than the domain name
    /// of the
    /// certificate. For example, your certificate name might be
    /// `WordPress-Blog-Certificate` and the domain name of the certificate might be
    /// `example.com`.
    certificate_name: []const u8,

    /// The name of the distribution that the certificate will be attached to.
    ///
    /// Use the `GetDistributions` action to get a list of distribution names that
    /// you
    /// can specify.
    distribution_name: []const u8,

    pub const json_field_names = .{
        .certificate_name = "certificateName",
        .distribution_name = "distributionName",
    };
};

pub const AttachCertificateToDistributionOutput = struct {
    /// An object that describes the result of the action, such as the status of the
    /// request, the
    /// timestamp of the request, and the resources affected by the request.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .operation = "operation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachCertificateToDistributionInput, options: CallOptions) !AttachCertificateToDistributionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachCertificateToDistributionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.AttachCertificateToDistribution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachCertificateToDistributionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AttachCertificateToDistributionOutput, body, allocator);
}
