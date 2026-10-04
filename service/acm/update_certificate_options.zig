const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateOptions = @import("certificate_options.zig").CertificateOptions;

pub const UpdateCertificateOptionsInput = struct {
    /// ARN of the requested certificate to update. This must be of the form:
    ///
    /// `arn:aws:acm:us-east-1:*account*:certificate/*12345678-1234-1234-1234-123456789012* `
    certificate_arn: []const u8,

    /// Use to update the options for your certificate. Currently, you can specify
    /// whether to add your certificate to a transparency log or export your
    /// certificate. Certificate transparency makes it possible to detect SSL/TLS
    /// certificates that have been mistakenly or maliciously issued. Certificates
    /// that have not been logged typically produce an error message in a browser.
    options: CertificateOptions,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .options = "Options",
    };
};

pub const UpdateCertificateOptionsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCertificateOptionsInput, options: CallOptions) !UpdateCertificateOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCertificateOptionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.UpdateCertificateOptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCertificateOptionsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
