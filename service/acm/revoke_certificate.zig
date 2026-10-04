const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevocationReason = @import("revocation_reason.zig").RevocationReason;

pub const RevokeCertificateInput = struct {
    /// The Amazon Resource Name (ARN) of the public or private certificate that
    /// will be revoked. The ARN must have the following form:
    ///
    /// `arn:aws:acm:region:account:certificate/12345678-1234-1234-1234-123456789012`
    certificate_arn: []const u8,

    /// Specifies why you revoked the certificate.
    revocation_reason: RevocationReason,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .revocation_reason = "RevocationReason",
    };
};

pub const RevokeCertificateOutput = struct {
    /// The Amazon Resource Name (ARN) of the public or private certificate that was
    /// revoked.
    certificate_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeCertificateInput, options: CallOptions) !RevokeCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeCertificateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.RevokeCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RevokeCertificateOutput, body, allocator);
}
